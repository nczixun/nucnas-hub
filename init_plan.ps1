# 强制 UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8
$planFile = "D:\nucnas-project\content_plan.json"

# 定义 50 款机型数据池 (模拟京东在售热门)
$models = @(
    # --- Day 1: 顶流 ---
    @{ day=1; brand="Apple"; model="Mac mini M4"; type="apple"; keywords="M4芯片,静音,雷电5"; status="pending" },
    @{ day=1; brand="Beelink"; model="SER8"; type="amd"; keywords="8845HS,金属机身,极致静音"; status="pending" },
    @{ day=1; brand="Minisforum"; model="MS-01"; type="intel"; keywords="双万兆,工作站,i9-13900H"; status="pending" },
    @{ day=1; brand="ASUS"; model="NUC 14 Pro Plus"; type="intel"; keywords="Ultra 9,AI PC,全新模具"; status="pending" },
    @{ day=1; brand="GMKtec"; model="K8"; type="amd"; keywords="8845HS,性价比,双网口"; status="pending" },

    # --- Day 2: 游戏 ---
    @{ day=2; brand="ASUS"; model="ROG NUC"; type="intel"; keywords="RTX4070,败家之眼,光追游戏"; status="pending" },
    @{ day=2; brand="Minisforum"; model="HX100G"; type="amd"; keywords="RX6650M,独显,液金散热"; status="pending" },
    @{ day=2; brand="Zotac"; model="Magnus ONE"; type="workstation"; keywords="桌面级4070,8L体积,双网口"; status="pending" },
    @{ day=2; brand="Beelink"; model="GTR7"; type="amd"; keywords="7840HS,指纹识别,磁吸电源"; status="pending" },
    @{ day=2; brand="MechRevo"; model="imini Pro"; type="intel"; keywords="Ultra 5,玻璃顶盖,游戏风"; status="pending" },

    # --- Day 3: N100/软路由 ---
    @{ day=3; brand="Beelink"; model="EQ13"; type="workstation"; keywords="N200,内置电源,双网口"; status="pending" },
    @{ day=3; brand="GMKtec"; model="G3"; type="amd"; keywords="N100,百元神机,办公"; status="pending" },
    @{ day=3; brand="Minisforum"; model="UN100D"; type="workstation"; keywords="N100,双2.5G,PD供电"; status="pending" },
    @{ day=3; brand="Aoostar"; model="R1"; type="nas"; keywords="N100,双盘位,NAS主机"; status="pending" },
    @{ day=3; brand="Morefine"; model="M9"; type="workstation"; keywords="N100,极小体积,随身携带"; status="pending" },

    # --- Day 4: 异构/进阶 ---
    @{ day=4; brand="Aoostar"; model="WTR Pro"; type="nas"; keywords="四盘位,5800U,All-in-One"; status="pending" },
    @{ day=4; brand="Minisforum"; model="MS-A1"; type="amd"; keywords="AM5插槽,可换CPU,8700G"; status="pending" },
    @{ day=4; brand="Khadas"; model="Mind"; type="workstation"; keywords="模块化,内置电池,雷电扩展"; status="pending" },
    @{ day=4; brand="GMKtec"; model="K9"; type="intel"; keywords="Ultra 125H,双风扇,雷电4"; status="pending" },
    @{ day=4; brand="Beelink"; model="SEi14"; type="intel"; keywords="Ultra 5,大风扇,静音"; status="pending" },

    # --- Day 5: 商务稳定 ---
    @{ day=5; brand="Xiaomi"; model="Mini Host"; type="intel"; keywords="i5-1240P,CNC铝合金,MIUI互联"; status="pending" },
    @{ day=5; brand="Lenovo"; model="ThinkCentre M90q"; type="workstation"; keywords="vPro,企业级,稳定"; status="pending" },
    @{ day=5; brand="Dell"; model="OptiPlex 7010 Micro"; type="workstation"; keywords="戴尔售后,十分紧凑,商务"; status="pending" },
    @{ day=5; brand="HP"; model="Elite Mini 800 G9"; type="workstation"; keywords="精英系列,扩展性强,静音"; status="pending" },
    @{ day=5; brand="ASUS"; model="NUC 14 Pro"; type="intel"; keywords="商用版,vPro,24x7运行"; status="pending" }
    
    # ... 后续 Day 6-10 可继续添加 ...
)

# 保存为 JSON 文件
$jsonContent = $models | ConvertTo-Json -Depth 3
[System.IO.File]::WriteAllLines($planFile, $jsonContent)

Write-Host "✅ 计划表已创建！文件位置: $planFile" -ForegroundColor Green
Write-Host "📅 包含 $($models.Count) 款热门机型，分批次生成。"
Write-Host "💡 接下来，你每天只需要告诉我：'帮我生成 Day X 的内容' 即可。"