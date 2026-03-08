#!/bin/bash

###############################################################################
# NAS 硬盘健康检测脚本
# 功能：SMART 检测 + 温度监控 + 坏道扫描 + 告警
# 使用：./smart-check.sh
# 定时：0 3 * * * /path/to/smart-check.sh
###############################################################################

# 配置项
TEMP_WARNING=45      # 温度警告阈值 (°C)
TEMP_CRITICAL=55     # 温度严重阈值 (°C)
REALLOCATED_WARNING=10    # 重映射扇区警告
REALLOCATED_CRITICAL=100  # 重映射扇区严重
POWER_ON_WARNING=30000    # 通电时间警告 (小时)
NOTIFY_ENABLE=true   # 是否启用通知
NOTIFY_METHOD="wechat"    # wechat/email/dingtalk
LOG_FILE="/var/log/smart-check.log"

# 颜色定义
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# 日志函数
log() {
    local level=$1
    local message=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "${timestamp} [${level}] ${message}" | tee -a "${LOG_FILE}"
}

# 检查依赖
check_dependencies() {
    if ! command -v smartctl &> /dev/null; then
        log "ERROR" "smartctl 未安装，请运行：apt install smartmontools 或 yum install smartmontools"
        exit 1
    fi
}

# 获取硬盘列表
get_drives() {
    lsblk -d -n -o NAME | grep -E '^(sd|hd|nvme|vd)'
}

# 检测单个硬盘
check_drive() {
    local drive=$1
    local status=0
    local warnings=""
    
    log "INFO" "正在检测硬盘：${drive}"
    echo -e "\n${GREEN}================================${NC}"
    echo -e "${GREEN}硬盘：/dev/${drive}${NC}"
    echo -e "${GREEN}================================${NC}"
    
    # 获取 SMART 信息
    local smart_info=$(smartctl -i /dev/${drive} 2>/dev/null)
    local smart_health=$(smartctl -H /dev/${drive} 2>/dev/null)
    local smart_attributes=$(smartctl -A /dev/${drive} 2>/dev/null)
    
    # 检查 SMART 总状态
    if echo "${smart_health}" | grep -q "PASSED"; then
        echo -e "SMART 状态：${GREEN}正常${NC}"
    elif echo "${smart_health}" | grep -q "FAILED"; then
        echo -e "SMART 状态：${RED}失败 - 建议立即备份数据！${NC}"
        status=2
        warnings="${warnings}SMART 检测失败\n"
    else
        echo -e "SMART 状态：${YELLOW}未知${NC}"
    fi
    
    # 检查温度
    local temp=$(echo "${smart_attributes}" | grep -i "Temperature" | awk '{print $10}' | head -1)
    if [ -z "${temp}" ]; then
        temp=$(echo "${smart_attributes}" | grep -i "Current_Drive_Temperature" | awk '{print $10}' | head -1)
    fi
    
    if [ -n "${temp}" ] && [ "${temp}" -gt 0 ] 2>/dev/null; then
        if [ "${temp}" -ge "${TEMP_CRITICAL}" ]; then
            echo -e "温度：${RED}${temp}°C (严重超温！)${NC}"
            status=2
            warnings="${warnings}硬盘 ${drive} 温度 ${temp}°C 超过严重阈值\n"
        elif [ "${temp}" -ge "${TEMP_WARNING}" ]; then
            echo -e "温度：${YELLOW}${temp}°C (偏高)${NC}"
            status=1
            warnings="${warnings}硬盘 ${drive} 温度 ${temp}°C 超过警告阈值\n"
        else
            echo -e "温度：${GREEN}${temp}°C${NC}"
        fi
    else
        echo -e "温度：${YELLOW}无法读取${NC}"
    fi
    
    # 检查重映射扇区
    local reallocated=$(echo "${smart_attributes}" | grep -i "Reallocated_Sector" | awk '{print $10}' | head -1)
    if [ -n "${reallocated}" ] && [ "${reallocated}" -gt 0 ] 2>/dev/null; then
        if [ "${reallocated}" -ge "${REALLOCATED_CRITICAL}" ]; then
            echo -e "重映射扇区：${RED}${reallocated} (严重！)${NC}"
            status=2
            warnings="${warnings}硬盘 ${drive} 重映射扇区 ${reallocated} 超过严重阈值\n"
        elif [ "${reallocated}" -ge "${REALLOCATED_WARNING}" ]; then
            echo -e "重映射扇区：${YELLOW}${reallocated} (注意观察)${NC}"
            status=1
            warnings="${warnings}硬盘 ${drive} 重映射扇区 ${reallocated} 超过警告阈值\n"
        else
            echo -e "重映射扇区：${GREEN}${reallocated}${NC}"
        fi
    else
        echo -e "重映射扇区：${GREEN}0${NC}"
    fi
    
    # 检查通电时间
    local power_on=$(echo "${smart_attributes}" | grep -i "Power_On_Hours" | awk '{print $10}' | head -1)
    if [ -n "${power_on}" ] && [ "${power_on}" -gt 0 ] 2>/dev/null; then
        local power_on_days=$((power_on / 24))
        if [ "${power_on}" -ge "${POWER_ON_WARNING}" ]; then
            echo -e "通电时间：${YELLOW}${power_on} 小时 (${power_on_days} 天)${NC}"
            status=1
            warnings="${warnings}硬盘 ${drive} 通电时间 ${power_on} 小时\n"
        else
            echo -e "通电时间：${GREEN}${power_on} 小时 (${power_on_days} 天)${NC}"
        fi
    else
        echo -e "通电时间：${YELLOW}无法读取${NC}"
    fi
    
    # 检查启动/停止计数
    local start_stop=$(echo "${smart_attributes}" | grep -i "Start_Stop_Count" | awk '{print $10}' | head -1)
    if [ -n "${start_stop}" ] && [ "${start_stop}" -gt 50 ] 2>/dev/null; then
        echo -e "启动/停止计数：${YELLOW}${start_stop} (频繁启停)${NC}"
        if [ "${start_stop}" -gt 200 ]; then
            warnings="${warnings}硬盘 ${drive} 启动/停止计数 ${start_stop} 过高\n"
        fi
    else
        echo -e "启动/停止计数：${GREEN}${start_stop:-0}${NC}"
    fi
    
    return ${status}
}

# 发送通知
send_notification() {
    local message=$1
    
    if [ "${NOTIFY_ENABLE}" != "true" ]; then
        return
    fi
    
    case "${NOTIFY_METHOD}" in
        wechat)
            # Server 酱推送
            local sct_key="${SCT_KEY:-}"
            if [ -n "${sct_key}" ]; then
                curl -s "https://sctapi.ftqq.com/${sct_key}.send?title=NAS 硬盘健康告警&desp=${message}" > /dev/null
                log "INFO" "微信通知已发送"
            fi
            ;;
        email)
            # 邮件通知
            local email="${NOTIFY_EMAIL:-}"
            if [ -n "${email}" ]; then
                echo -e "${message}" | mail -s "NAS 硬盘健康告警" "${email}"
                log "INFO" "邮件通知已发送至 ${email}"
            fi
            ;;
        dingtalk)
            # 钉钉机器人
            local dingtalk_webhook="${DINGTALK_WEBHOOK:-}"
            if [ -n "${dingtalk_webhook}" ]; then
                curl -s -X POST "${dingtalk_webhook}" \
                    -H "Content-Type: application/json" \
                    -d "{\"msgtype\":\"text\",\"text\":{\"content\":\"NAS 硬盘健康告警\n\n${message}\"}}" > /dev/null
                log "INFO" "钉钉通知已发送"
            fi
            ;;
    esac
}

# 生成报告
generate_report() {
    local report_file="/tmp/smart-report-$(date +%Y%m%d).txt"
    
    {
        echo "NAS 硬盘健康检测报告"
        echo "生成时间：$(date '+%Y-%m-%d %H:%M:%S')"
        echo "================================"
        smartctl --scan | while read line; do
            local drive=$(echo "${line}" | awk '{print $1}' | sed 's/\/dev\///')
            smartctl -i /dev/${drive} 2>/dev/null
            smartctl -H /dev/${drive} 2>/dev/null
            echo ""
        done
    } > "${report_file}"
    
    log "INFO" "报告已生成：${report_file}"
    echo -e "\n${GREEN}详细报告已保存至：${report_file}${NC}"
}

# 主函数
main() {
    log "INFO" "========== 开始硬盘健康检测 =========="
    
    check_dependencies
    
    local drives=$(get_drives)
    local total_status=0
    local warning_messages=""
    
    if [ -z "${drives}" ]; then
        log "ERROR" "未找到硬盘"
        exit 1
    fi
    
    echo -e "${GREEN}================================${NC}"
    echo -e "${GREEN}   NAS 硬盘健康检测${NC}"
    echo -e "${GREEN}   $(date '+%Y-%m-%d %H:%M:%S')${NC}"
    echo -e "${GREEN}================================${NC}"
    
    for drive in ${drives}; do
        check_drive "${drive}"
        local drive_status=$?
        if [ ${drive_status} -gt ${total_status} ]; then
            total_status=${drive_status}
        fi
    done
    
    # 生成报告
    generate_report
    
    # 总结
    echo -e "\n${GREEN}================================${NC}"
    case ${total_status} in
        0)
            echo -e "${GREEN}检测结果：所有硬盘正常 ✅${NC}"
            log "INFO" "检测结果：所有硬盘正常"
            ;;
        1)
            echo -e "${YELLOW}检测结果：存在警告，请关注 ⚠️${NC}"
            log "WARNING" "检测结果：存在警告"
            ;;
        2)
            echo -e "${RED}检测结果：存在严重问题，立即处理！🚨${NC}"
            log "ERROR" "检测结果：存在严重问题"
            ;;
    esac
    echo -e "${GREEN}================================${NC}\n"
    
    # 发送通知（如果有警告）
    if [ ${total_status} -ge 1 ] && [ "${NOTIFY_ENABLE}" = "true" ]; then
        send_notification "检测到 ${total_status} 个警告，请登录 NAS 查看详情"
    fi
    
    log "INFO" "========== 检测完成 =========="
    
    return ${total_status}
}

# 运行主函数
main
exit $?
