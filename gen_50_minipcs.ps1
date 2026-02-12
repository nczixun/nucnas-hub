# 强制 UTF-8 编码，防止乱码
$OutputEncoding = [System.Text.Encoding]::UTF8

$baseDir = "D:\nucnas-project"
$targetDir = "$baseDir\content\hardware"

# 检查目录
if (-not (Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir -Force }

# --- 50 款主流 Mini PC 数据库 (格式: 品牌|型号|核心配置|官网基地址) ---
$db = @(
    # --- Apple ---
    "Apple|Mac mini M4|Apple M4 Chip|https://www.apple.com/mac-mini/",
    "Apple|Mac mini M4 Pro|Apple M4 Pro Chip|https://www.apple.com/mac-mini/",
    "Apple|Mac Studio M2 Max|Apple M2 Max|https://www.apple.com/mac-studio/",
    "Apple|Mac Studio M2 Ultra|Apple M2 Ultra|https://www.apple.com/mac-studio/",
    
    # --- ASUS / Intel NUC ---
    "ASUS|NUC 14 Pro+|Core Ultra 9 185H|https://www.asus.com/displays-desktops/nucs/",
    "ASUS|NUC 14 Pro|Core Ultra 7 155H|https://www.asus.com/displays-desktops/nucs/",
    "ASUS|ROG NUC|Core Ultra 9 + RTX 4070|https://rog.asus.com/desktops/",
    "Intel|NUC 13 Extreme|i9-13900K (Raptor Canyon)|https://www.asus.com",
    "Intel|NUC 12 Enthusiast|i7-12700H + A770M (Serpent Canyon)|https://www.asus.com",
    "Intel|NUC 11 Extreme|i9-11900KB (Beast Canyon)|https://www.asus.com",
    
    # --- Minisforum (铭凡) ---
    "Minisforum|MS-01|i9-13900H Workstation|https://store.minisforum.com/",
    "Minisforum|UM790 Pro|Ryzen 9 7940HS|https://store.minisforum.com/",
    "Minisforum|UM780 XTX|Ryzen 7 7840HS (Oculink)|https://store.minisforum.com/",
    "Minisforum|HX99G|Ryzen 9 6900HX + RX 6600M|https://store.minisforum.com/",
    "Minisforum|EM680|Ryzen 7 6800U (超微型)|https://store.minisforum.com/",
    "Minisforum|V3 Tablet|Ryzen 7 8840U (三合一平板)|https://store.minisforum.com/",
    "Minisforum|NPB7|i7-13700H|https://store.minisforum.com/",
    "Minisforum|UN1265|i7-12650H|https://store.minisforum.com/",
    "Minisforum|NAB6|i7-12650H (双网口)|https://store.minisforum.com/",
    "Minisforum|MS-A1|Ryzen 8700G (AM5 Socket)|https://store.minisforum.com/",

    # --- Beelink (零刻) ---
    "Beelink|SER8|Ryzen 7 8845HS|https://www.bee-link.com/",
    "Beelink|SER7|Ryzen 7 7840HS|https://www.bee-link.com/",
    "Beelink|GTR7 Pro|Ryzen 9 7940HS|https://www.bee-link.com/",
    "Beelink|SEi14|Core Ultra 5 125H|https://www.bee-link.com/",
    "Beelink|SEi12|i5-12450H|https://www.bee-link.com/",
    "Beelink|EQ13|N200 (静音办公)|https://www.bee-link.com/",
    "Beelink|SER6 Max|Ryzen 7 7735HS|https://www.bee-link.com/",
    
    # --- Geekom (积核) ---
    "Geekom|A8|Ryzen 9 8945HS|https://www.geekompc.com/",
    "Geekom|A7|Ryzen 9 7940HS|https://www.geekompc.com/",
    "Geekom|IT13|i9-13900H|https://www.geekompc.com/",
    "Geekom|Mini IT12|i7-12650H|https://www.geekompc.com/",
    "Geekom|XT12 Pro|i9-12900H|https://www.geekompc.com/",
    "Geekom|AX8 Pro|Ryzen 9 8945HS|https://www.geekompc.com/",

    # --- GMKtec (极摩客) ---
    "GMKtec|K8|Ryzen 7 8845HS|https://www.gmktec.com/",
    "GMKtec|K6|Ryzen 7 7840HS|https://www.gmktec.com/",
    "GMKtec|NucBox M5|Ryzen 7 5700U|https://www.gmktec.com/",
    "GMKtec|G3|Intel N100|https://www.gmktec.com/",
    "GMKtec|K9|Core Ultra 5 125H|https://www.gmktec.com/",

    # --- Zotac (索泰) ---
    "Zotac|ZBOX Magnus ONE|RTX 4070 Desktop|https://www.zotac.com/",
    "Zotac|ZBOX Edge|Slim Profile|https://www.zotac.com/",
    
    # --- Enterprise (御三家) ---
    "Lenovo|ThinkCentre M70q|Tiny Desktop|https://www.lenovo.com/",
    "Lenovo|ThinkCentre M90q Gen 4|i9-13900|https://www.lenovo.com/",
    "HP|Elite Mini 800 G9|i9-13900|https://www.hp.com/",
    "Dell|OptiPlex Micro 7010|Business Compact|https://www.dell.com/",
    "Dell|Precision 3260|Compact Workstation|https://www.dell.com/",
    
    # --- Others ---
    "Khadas|Mind|Modular Workstation|https://www.khadas.com/",
    "Morefine|M600|Ryzen 9 6900HX|https://morefine.com/",
    "Chatreey|Tank 03|Gaming Mini PC|https://www.chatreey.com/",
    "Aoostar|GEM12|Ryzen 7 8845HS (Oculink)|https://aoostar.com/",
    "Aoostar|GOD78|Ryzen 7 7840HS|https://aoostar.com/"
)

Write-Host ">>> 正在生成 50 款 Mini PC 数据库..." -ForegroundColor Cyan

$count = 0
foreach ($line in $db) {
    $p = $line.Split("|")
    $brand = $p[0]
    $model = $p[1]
    $cpu = $p[2]
    $url = $p[3]
    
    # 生成安全的文件名 (替换空格为横杠，转小写)
    $filename = "$brand-$model".ToLower().Replace(" ", "-").Replace("/", "-") + ".md"
    $fullPath = "$targetDir\$filename"
    
    # 构建搜索链接 (KOL 测评)
    $searchKey = "$brand $model review"
    $bilibiliSearch = "https://search.bilibili.com/all?keyword=$brand+$model+测评"
    $youtubeSearch = "https://www.youtube.com/results?search_query=$brand+$model+review"
    
    $content = @"
---
title: "$brand $model"
date: $(Get-Date -Format "yyyy-MM-dd")
summary: "$brand $model 搭载 $cpu，是 $brand 旗下的主力机型。"
categories: ["hardware"]
tags: ["$brand", "MiniPC", "$cpu"]
---

<div style="text-align: center; margin-bottom: 40px;">
    <h1 style="font-size: 48px; font-weight: 700; margin-bottom: 10px;">$model</h1>
    <p style="color: #86868B; font-size: 20px;">$brand // $cpu</p>
</div>

<!-- Apple 风格参数卡片 -->
<div class="glass-card" style="margin-bottom: 40px; text-align: left;">
    <h2 style="font-size: 24px; margin-bottom: 20px;">核心规格速览</h2>
    <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
        <div>
            <span style="display: block; font-size: 12px; color: #86868B; text-transform: uppercase;">Processor</span>
            <span style="font-weight: 600;">$cpu</span>
        </div>
        <div>
            <span style="display: block; font-size: 12px; color: #86868B; text-transform: uppercase;">Form Factor</span>
            <span style="font-weight: 600;">Mini PC</span>
        </div>
        <div>
            <span style="display: block; font-size: 12px; color: #86868B; text-transform: uppercase;">Brand</span>
            <span style="font-weight: 600;">$brand</span>
        </div>
        <div>
            <span style="display: block; font-size: 12px; color: #86868B; text-transform: uppercase;">Usage</span>
            <span style="font-weight: 600;">HomeLab / Office</span>
        </div>
    </div>
</div>

<!-- 外部链接按钮组 -->
<div style="display: flex; flex-direction: column; gap: 15px;">
    
    <!-- 官方链接 -->
    <a href="$url" target="_blank" class="glass-card" style="display: flex; justify-content: space-between; align-items: center; text-decoration: none; color: inherit; padding: 20px;">
        <div style="display: flex; align-items: center; gap: 15px;">
            <div style="width: 40px; height: 40px; background: #0071E3; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;">官</div>
            <div>
                <div style="font-weight: 600;">访问 $brand 官方网站</div>
                <div style="font-size: 12px; color: #86868B;">查看详细技术规格与驱动下载</div>
            </div>
        </div>
        <span style="color: #0071E3;">Go &rarr;</span>
    </a>

    <!-- KOL 测评聚合 (Bilibili) -->
    <a href="$bilibiliSearch" target="_blank" class="glass-card" style="display: flex; justify-content: space-between; align-items: center; text-decoration: none; color: inherit; padding: 20px;">
        <div style="display: flex; align-items: center; gap: 15px;">
            <div style="width: 40px; height: 40px; background: #FB7299; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;">B</div>
            <div>
                <div style="font-weight: 600;">Bilibili 视频测评</div>
                <div style="font-size: 12px; color: #86868B;">查看国内 UP 主的拆解与实测</div>
            </div>
        </div>
        <span style="color: #FB7299;">Watch &rarr;</span>
    </a>

    <!-- KOL 测评聚合 (YouTube) -->
    <a href="$youtubeSearch" target="_blank" class="glass-card" style="display: flex; justify-content: space-between; align-items: center; text-decoration: none; color: inherit; padding: 20px;">
        <div style="display: flex; align-items: center; gap: 15px;">
            <div style="width: 40px; height: 40px; background: #FF0000; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-weight: bold;">Y</div>
            <div>
                <div style="font-weight: 600;">YouTube Global Reviews</div>
                <div style="font-size: 12px; color: #86868B;">全球科技媒体评测汇总</div>
            </div>
        </div>
        <span style="color: #FF0000;">Watch &rarr;</span>
    </a>

</div>

<div style="margin-top: 40px; padding-top: 20px; border-top: 1px solid #E5E5E5; text-align: center; color: #86868B; font-size: 12px;">
    * 测评链接为实时搜索生成，确保获取最新内容。
</div>
"@
    
    [System.IO.File]::WriteAllLines($fullPath, $content)
    Write-Host "  [OK] $filename" -ForegroundColor Green
    $count++
}

Write-Host "`n成功生成 $count 款 Mini PC 资料页！" -ForegroundColor Yellow
Write-Host "请运行 hugo server 查看效果。"
Read-Host