#!/bin/bash

###############################################################################
# Docker 批量部署脚本
# 功能：一键部署常用 NAS 容器
# 使用：./docker-deploy.sh install jellyfin
###############################################################################

# 配置项
DOCKER_BASE="/docker"
DATA_BASE="/data"
BACKUP_BASE="/backup"

# 颜色定义
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# 容器配置
declare -A CONTAINERS
CONTAINERS=(
    ["jellyfin"]="媒体服务器|8096|jellyfin/jellyfin"
    ["qbittorrent"]="BT 下载|8080|linuxserver/qbittorrent"
    ["navidrome"]="音乐服务器|4533|deluan/navidrome"
    ["nextcloud"]="私有云盘|8081|nextcloud"
    ["homeassistant"]="智能家居|8123|homeassistant/home-assistant"
    ["portainer"]="容器管理|9000|portainer/portainer-ce"
    ["transmission"]="PT 下载|9091|linuxserver/transmission"
    ["alist"]="网盘挂载|5244|xhofe/alist"
    ["emby"]="媒体服务器|8097|emby/embyserver"
    ["syncthing"]="文件同步|8384|syncthing/syncthing"
    ["filebrowser"]="文件管理|8082|filebrowser/filebrowser"
    ["uptime-kuma"]="服务监控|3001|louislam/uptime-kuma"
)

# 日志函数
log() {
    local level=$1
    local message=$2
    echo -e "[$(date '+%H:%M:%S')] [${level}] ${message}"
}

# 检查依赖
check_dependencies() {
    if ! command -v docker &> /dev/null; then
        log "ERROR" "Docker 未安装"
        exit 1
    fi
}

# 创建目录结构
create_directories() {
    local app=$1
    log "INFO" "创建目录结构..."
    
    mkdir -p "${DOCKER_BASE}/${app}/config"
    mkdir -p "${DATA_BASE}/${app}"
    mkdir -p "${BACKUP_BASE}/${app}"
    
    log "INFO" "目录创建完成"
}

# 部署 Jellyfin
deploy_jellyfin() {
    log "INFO" "部署 Jellyfin 媒体服务器..."
    
    create_directories "jellyfin"
    
    docker run -d \
        --name jellyfin \
        --restart unless-stopped \
        -p 8096:8096 \
        -v "${DOCKER_BASE}/jellyfin/config:/config" \
        -v "${DATA_BASE}/media:/media:ro" \
        -v "${DATA_BASE}/transcodes:/transcodes" \
        --device /dev/dri:/dev/dri \
        jellyfin/jellyfin
    
    log "INFO" "Jellyfin 部署完成！访问：http://localhost:8096"
}

# 部署 qBittorrent
deploy_qbittorrent() {
    log "INFO" "部署 qBittorrent..."
    
    create_directories "qbittorrent"
    
    docker run -d \
        --name qbittorrent \
        --restart unless-stopped \
        -p 8080:8080 \
        -p 6881:6881 \
        -p 6881:6881/udp \
        -v "${DOCKER_BASE}/qbittorrent/config:/config" \
        -v "${DATA_BASE}/downloads:/downloads" \
        linuxserver/qbittorrent
    
    log "INFO" "qBittorrent 部署完成！访问：http://localhost:8080"
}

# 部署 Navidrome
deploy_navidrome() {
    log "INFO" "部署 Navidrome 音乐服务器..."
    
    create_directories "navidrome"
    
    docker run -d \
        --name navidrome \
        --restart unless-stopped \
        -p 4533:4533 \
        -v "${DOCKER_BASE}/navidrome/config:/app/data" \
        -v "${DATA_BASE}/music:/music:ro" \
        deluan/navidrome
    
    log "INFO" "Navidrome 部署完成！访问：http://localhost:4533"
}

# 部署 Nextcloud
deploy_nextcloud() {
    log "INFO" "部署 Nextcloud 私有云盘..."
    
    create_directories "nextcloud"
    
    docker run -d \
        --name nextcloud \
        --restart unless-stopped \
        -p 8081:80 \
        -v "${DOCKER_BASE}/nextcloud/html:/var/www/html" \
        -v "${DATA_BASE}/nextcloud:/var/www/html/custom_apps" \
        nextcloud
    
    log "INFO" "Nextcloud 部署完成！访问：http://localhost:8081"
}

# 部署 Home Assistant
deploy_homeassistant() {
    log "INFO" "部署 Home Assistant..."
    
    create_directories "homeassistant"
    
    docker run -d \
        --name homeassistant \
        --restart unless-stopped \
        -p 8123:8123 \
        -v "${DOCKER_BASE}/homeassistant/config:/config" \
        --network host \
        homeassistant/home-assistant
    
    log "INFO" "Home Assistant 部署完成！访问：http://localhost:8123"
}

# 部署 Portainer
deploy_portainer() {
    log "INFO" "部署 Portainer 容器管理..."
    
    create_directories "portainer"
    
    docker run -d \
        --name portainer \
        --restart unless-stopped \
        -p 9000:9000 \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -v "${DOCKER_BASE}/portainer/data:/data" \
        portainer/portainer-ce
    
    log "INFO" "Portainer 部署完成！访问：http://localhost:9000"
}

# 部署 Transmission
deploy_transmission() {
    log "INFO" "部署 Transmission..."
    
    create_directories "transmission"
    
    docker run -d \
        --name transmission \
        --restart unless-stopped \
        -p 9091:9091 \
        -p 51413:51413 \
        -p 51413:51413/udp \
        -v "${DOCKER_BASE}/transmission/config:/config" \
        -v "${DATA_BASE}/downloads:/downloads" \
        -v "${DATA_BASE}/downloads/watch:/watch" \
        -v "${DATA_BASE}/downloads/complete:/downloads-complete" \
        linuxserver/transmission
    
    log "INFO" "Transmission 部署完成！访问：http://localhost:9091"
}

# 部署 Alist
deploy_alist() {
    log "INFO" "部署 Alist 网盘挂载..."
    
    create_directories "alist"
    
    docker run -d \
        --name alist \
        --restart unless-stopped \
        -p 5244:5244 \
        -v "${DOCKER_BASE}/alist/data:/opt/alist/data" \
        -v "${DATA_BASE}/alist:/mnt" \
        xhofe/alist
    
    log "INFO" "Alist 部署完成！访问：http://localhost:5244"
}

# 部署 Emby
deploy_emby() {
    log "INFO" "部署 Emby 媒体服务器..."
    
    create_directories "emby"
    
    docker run -d \
        --name emby \
        --restart unless-stopped \
        -p 8097:8096 \
        -v "${DOCKER_BASE}/emby/config:/config" \
        -v "${DATA_BASE}/media:/data:ro" \
        -v "${DATA_BASE}/transcodes:/transcodes" \
        --device /dev/dri:/dev/dri \
        emby/embyserver
    
    log "INFO" "Emby 部署完成！访问：http://localhost:8097"
}

# 部署 Syncthing
deploy_syncthing() {
    log "INFO" "部署 Syncthing 文件同步..."
    
    create_directories "syncthing"
    
    docker run -d \
        --name syncthing \
        --restart unless-stopped \
        -p 8384:8384 \
        -p 22000:22000/tcp \
        -p 22000:22000/udp \
        -v "${DOCKER_BASE}/syncthing/config:/var/syncthing" \
        -v "${DATA_BASE}/sync:/sync" \
        syncthing/syncthing
    
    log "INFO" "Syncthing 部署完成！访问：http://localhost:8384"
}

# 部署 File Browser
deploy_filebrowser() {
    log "INFO" "部署 File Browser 文件管理..."
    
    create_directories "filebrowser"
    
    docker run -d \
        --name filebrowser \
        --restart unless-stopped \
        -p 8082:80 \
        -v "${DATA_BASE}:/srv" \
        -v "${DOCKER_BASE}/filebrowser/database.db:/database.db" \
        -v "${DOCKER_BASE}/filebrowser/config.json:/.filebrowser.json" \
        filebrowser/filebrowser
    
    log "INFO" "File Browser 部署完成！访问：http://localhost:8082"
}

# 部署 Uptime Kuma
deploy_uptime_kuma() {
    log "INFO" "部署 Uptime Kuma 服务监控..."
    
    create_directories "uptime-kuma"
    
    docker run -d \
        --name uptime-kuma \
        --restart unless-stopped \
        -p 3001:3001 \
        -v "${DOCKER_BASE}/uptime-kuma/data:/app/data" \
        louislam/uptime-kuma
    
    log "INFO" "Uptime Kuma 部署完成！访问：http://localhost:3001"
}

# 列出可用容器
list_containers() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}   可用容器列表${NC}"
    echo -e "${BLUE}================================${NC}\n"
    
    printf "%-20s %-15s %-10s %s\n" "容器名" "描述" "端口" "镜像"
    echo "--------------------------------------------------------"
    
    for key in "${!CONTAINERS[@]}"; do
        IFS='|' read -r desc port image <<< "${CONTAINERS[$key]}"
        printf "%-20s %-15s %-10s %s\n" "${key}" "${desc}" "${port}" "${image}"
    done
    
    echo ""
}

# 显示已部署容器
list_deployed() {
    echo -e "${GREEN}================================${NC}"
    echo -e "${GREEN}   已部署的容器${NC}"
    echo -e "${GREEN}================================${NC}\n"
    
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

# 部署单个容器
deploy_container() {
    local app=$1
    
    if [ -z "${CONTAINERS[$app]}" ]; then
        log "ERROR" "未知容器：${app}"
        echo "使用 './docker-deploy.sh list' 查看可用容器"
        exit 1
    fi
    
    # 检查是否已部署
    if docker ps -a --format '{{.Names}}' | grep -q "^${app}$"; then
        log "WARNING" "${app} 已部署，是否删除后重新部署？(y/n)"
        read -r response
        if [[ "${response}" =~ ^[Yy]$ ]]; then
            docker rm -f "${app}"
            log "INFO" "已删除旧容器"
        else
            log "INFO" "取消部署"
            exit 0
        fi
    fi
    
    # 调用对应的部署函数
    local func_name="deploy_${app}"
    if type "${func_name}" &> /dev/null; then
        ${func_name}
    else
        log "ERROR" "部署函数不存在：${func_name}"
        exit 1
    fi
}

# 部署所有容器
deploy_all() {
    log "INFO" "开始部署所有容器..."
    
    for key in "${!CONTAINERS[@]}"; do
        deploy_container "${key}"
        sleep 2
    done
    
    log "INFO" "所有容器部署完成！"
}

# 删除容器
remove_container() {
    local app=$1
    
    if docker ps -a --format '{{.Names}}' | grep -q "^${app}$"; then
        docker rm -f "${app}"
        log "INFO" "${app} 已删除"
    else
        log "ERROR" "${app} 未部署"
    fi
}

# 显示帮助
show_help() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}   Docker 批量部署脚本${NC}"
    echo -e "${BLUE}================================${NC}"
    echo ""
    echo "用法：./docker-deploy.sh <命令> [参数]"
    echo ""
    echo "命令:"
    echo "  list              列出可用容器"
    echo "  deployed          显示已部署容器"
    echo "  install <容器名>   部署指定容器"
    echo "  remove <容器名>    删除指定容器"
    echo "  all               部署所有容器"
    echo "  help              显示帮助"
    echo ""
    echo "示例:"
    echo "  ./docker-deploy.sh list"
    echo "  ./docker-deploy.sh install jellyfin"
    echo "  ./docker-deploy.sh remove qbittorrent"
    echo ""
}

# 主函数
main() {
    check_dependencies
    
    local command=${1:-help}
    local param=${2:-}
    
    case "${command}" in
        list)
            list_containers
            ;;
        deployed)
            list_deployed
            ;;
        install)
            if [ -z "${param}" ]; then
                log "ERROR" "请指定容器名"
                show_help
                exit 1
            fi
            deploy_container "${param}"
            ;;
        remove)
            if [ -z "${param}" ]; then
                log "ERROR" "请指定容器名"
                show_help
                exit 1
            fi
            remove_container "${param}"
            ;;
        all)
            deploy_all
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            log "ERROR" "未知命令：${command}"
            show_help
            exit 1
            ;;
    esac
}

# 运行主函数
main "$@"
