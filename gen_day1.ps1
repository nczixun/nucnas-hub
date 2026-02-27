# 强制 UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8
$baseDir = "D:\nucnas-project"
$targetDir = "$baseDir\content\hardware"

$day1_posts = @(
    @{
        brand="Apple"; model="Mac mini M4 Pro"; cpu="Apple M4 Pro"; platform="apple";
        title="Mac mini M4 Pro：迷你主机的算力天花板";
        summary="搭载 M4 Pro 芯片，雷电 5 接口首秀。这台小主机不仅是办公神器，更是移动工作站的有力挑战者。";
        pros="M4 Pro 性能炸裂, 支持雷电 5 接口, 64GB 内存可选, 极致能效比";
        cons="价格昂贵, 必须选配大内存, 接口全 C 化需适应";
        body="## 1. 性能怪兽`nM4 Pro 芯片拥有更多的核心和更强的 GPU 性能，处理 8K 视频和 3D 渲染不再是话下。`n`n## 2. 雷电 5 协议`n这是首次在 Mac mini 上引入雷电 5，带宽翻倍，外接高性能存储极速体验。"
    },
    @{
        brand="Apple"; model="Mac mini M4"; cpu="Apple M4"; platform="apple";
        title="Mac mini M4 深度评测：3000元价位，它依然没有对手";
        summary="体积缩小一半，性能提升巨大。M4 芯片让这台只有手掌大小的机器成为了 2024 年最值得购买的桌面电脑。";
        pros="极致静音, 做工无敌, 单核性能强悍, 性价比极高";
        cons="电源键位置反人类, 无 USB-A 接口, 内存硬盘扩展贵";
        body="## 1. 设计：再次定义的 Mini`n全新的 Mac mini M4 体积缩减到了 12.7cm。唯一的槽点是电源键被移到了底部。`n`n## 2. 性能：M4 的降维打击`n在 Geekbench 6 跑分中，M4 单核性能傲视群雄。"
    }
    # ... 其他 3 个型号省略，格式一致 ...
)

foreach ($post in $day1_posts) {
    $filename = "$($post.brand)-$($post.model)".ToLower().Replace(" ", "-").Replace("/", "-") + ".md"
    $fullPath = "$targetDir\$filename"
    $jd_link = "https://search.jd.com/Search?keyword=$($post.brand)+$($post.model)"

    # 核心修正：将 pros 和 cons 写入 Front Matter 区域
    $md = "---`n"
    $md += "title: `"$($post.title)`"`n"
    $md += "date: $((Get-Date).ToString('yyyy-MM-dd'))`n"
    $md += "summary: `"$($post.summary)`"`n"
    $md += "categories: [`"hardware`"]`n"
    $md += "brand: `"$($post.brand)`"`n"
    $md += "platform: `"$($post.platform)`"`n"
    $md += "official_url: `"$jd_link`"`n"
    $md += "bilibili_url: `"https://search.bilibili.com/all?keyword=$($post.brand)+$($post.model)`"`n"
    $md += "youtube_url: `"https://www.youtube.com/results?search_query=$($post.brand)+$($post.model)`"`n"
    $md += "pros: `"$($post.pros)`"`n"
    $md += "cons: `"$($post.cons)`"`n"
    $md += "---`n`n"
    $md += "$($post.body)"

    [System.IO.File]::WriteAllLines($fullPath, $md)
    Write-Host "SUCCESS: $($post.file)" -ForegroundColor Green
}