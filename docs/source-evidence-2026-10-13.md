# 131 页来源证据完善记录（2026-10-13）

本次依据用户“继续完善 131 页缺少完整来源证据”的新授权执行；长期自动化保持停用。

## 实际结果

- 131 页均完成逐页处置，原文章文件与全部公开文章 URL 保留。
- 106 页：按实际取得的官方资料改写，正文列出事实、直接来源及核查范围。部分历史评测缩减为版本核对或资料入口；此数不表示原有实测得到证实，也不表示恢复了完整硬件参数。
- 25 页：仍缺对应型号/版本的可靠证据，保留 pending，不设置 reviewedAt。逐页缺口见下表。
- 无原始记录的跑分、帧率、功耗、噪音、价格与第一人称体验从当前正文撤下；旧版本保留于 Git 历史。未恢复这些历史实测，不将厂商宣传当作本站测试。
- 删除文章元数据中无依据的价格、评分、雷达值、优缺点和视频搜索地址；图片不是设备实拍的库存素材不再用于这些页面。
- 纠正 HX100G 平台、M4/M4 Pro 接口、N350 核心数、SEi14 版本、SER8 版本、M9 商品页变化；修正错误的 RX6650M 等检索标签。
- 硬件入口改为明确的官方资料与选型说明。被撤下的不实标签旧地址提供静态跳转，避免旧入口失效。
- GEAKOS 通过浏览器读取官方安装指南、下载页、主页校验弹窗和发布记录。说明 x86/ARM 边界、目标盘清除、实际版本核对，以及旧安装文档 9080 与 v1.0.20 新增 HTTPS 9443 的差异。没有执行安装脚本、建池或设备迁移。

## 证据与验证

逐页事实、来源 URL、遗留理由及改写前后正文哈希：`source-evidence-131-ledger.json`；仓库对应文件为 `docs/source-evidence-2026-10-13.json`。

新增 `scripts/verify_source_evidence.py` 并接入 CI：防止正文、核查状态、证据清单与原 URL 脱节。这是编辑一致性检查，不能自动证明外部资料真实性。

本地 Hugo 0.152.2：381 个唯一文章路径；131 条证据记录；19 个关键入口；378 条搜索记录；全站内部链接与锚点无缺失。RAG 示例、浏览器算术与搜索筛选回归通过。生产 Hugo 0.147.7 的 CI 检查须另行通过后合并。

部分来源只能从浏览器或搜索缓存读取；403/不可读的旧手册没有计为已读。厂商支持目录只支持该页明确列出的版本名称，不能代替整机实测。

## 25 页仍待核查

| 页面 | 具体缺口 |
|---|---|
| [AOOSTAR W11：来源核查与遗留问题](https://www.nucnas.top/review/aoostar-w11/) | 未找到与 W11 对应的正式产品或说明书，不能把 Windows 11 的缩写或 WTR MAX 当成该型号。 |
| [ROG NUC 2026：来源核查与遗留问题](https://www.nucnas.top/review/asus-rog-nuc-2026/) | 已找到 ROG NUC（2025）官方页面，但不能以该页面证明旧稿所称 2026 型号。 |
| [ROG NUC：来源核查与遗留问题](https://www.nucnas.top/review/asus-rog-nuc/) | 旧稿没有完整销售代码和年份，2025 页不能证明旧款 CPU、GPU 与售价。 |
| [畅网 N100 软路由：来源核查与遗留问题](https://www.nucnas.top/review/changwang-soft-router-n100/) | Soft Router N100 是用途与 CPU 描述，缺少具体主板或整机代码；不能核实网卡、端口和供电。 |
| [Beelink EQR5：来源核查与遗留问题](https://www.nucnas.top/review/eqr5/) | 支持目录有 EQR5，但还缺少旧稿 CPU 与扩展配置的对应说明书。 |
| [GMKtec K5 Plus：来源核查与遗留问题](https://www.nucnas.top/review/gmktec-k5-plus/) | 支持目录列 K5，尚未确认 K5 Plus 的独立型号与正式规格；不以 K5 资料代替。 |
| [GMKtec K8：来源核查与遗留问题](https://www.nucnas.top/review/gmktec-k8/) | 支持中心列 K8；当前 K8 Plus 商品资料不能证明旧 K8 的全部端口和配置。 |
| [GMKtec NucBox K8：来源核查与遗留问题](https://www.nucnas.top/review/%E6%9E%81%E6%91%A9%E5%AE%A2-nucbox-k8-%E6%B5%8B%E8%AF%84ryzen-7-8845hs-%E6%80%A7%E4%BB%B7%E6%AF%94%E4%B9%8B%E7%8E%8B/) | 原稿型号与当前 K8 Plus 容易混用，缺少该旧款完整规格及原始评测记录。 |
| [Beelink GTR7 7940HS：来源核查与遗留问题](https://www.nucnas.top/review/gtr7-7940hs/) | 官方支持列表 GTR7 标为 7840HS；旧稿 7940HS 可能涉及不同 Pro 版本，尚缺直接证据。 |
| [Beelink GTR8：来源核查与遗留问题](https://www.nucnas.top/review/gtr8/) | 当前产品与文档目录没有找到可对应旧稿的正式 GTR8 产品规格。型号出现在认证或讨论中不等于该配置已销售。 |
| [神舟 N150 迷你主机：来源核查与遗留问题](https://www.nucnas.top/review/intel-n150%E6%9D%A5%E4%BA%86%E7%A5%9E%E8%88%9Fpc%E6%96%B0%E5%93%81%E5%8F%91%E5%B8%83%E5%85%A5%E9%97%A8%E8%BF%B7%E4%BD%A0%E4%B8%BB%E6%9C%BA%E6%96%B0%E9%80%89%E6%8B%A9/) | 原稿未给出完整神舟整机代码；Intel N150 规格无法证明神舟机器的端口、内存或待机功耗。 |
| [机械师 Creator Mini：来源核查与遗留问题](https://www.nucnas.top/review/%E6%9C%BA%E6%A2%B0%E5%B8%88-%E5%88%9B%E7%89%A9%E8%80%85-mini-%E6%B5%8B%E8%AF%84i7-13620h-%E9%AB%98%E6%80%A7%E8%83%BD%E5%95%86%E5%8A%A1%E4%B8%BB%E6%9C%BA/) | 未取得对应 Creator Mini 的正式型号代码与官方规格文档。 |
| [机械革命 imini Pro：来源核查与遗留问题](https://www.nucnas.top/review/%E6%9C%BA%E6%A2%B0%E9%9D%A9%E5%91%BDimini-pro%E8%AF%84%E6%B5%8Bultra-5-%E7%8E%BB%E7%92%83%E9%A1%B6%E7%9B%96%E6%B8%B8%E6%88%8F%E9%A3%8E%E6%A0%BC%E6%A1%8C%E9%9D%A2%E4%B8%BB%E6%9C%BA/) | 未取得对应 imini Pro 的正式型号代码与官方规格文档。 |
| [MINISFORUM EM680：来源核查与遗留问题](https://www.nucnas.top/review/minisforum-em680/) | 支持中心有 EM680，但旧稿的 6800U 配置尚无可读的对应规格或手册。官方翻新目录的 EM680/EM780 条目显示 7735U，链接路径还含 V3 SE；这些相互冲突的信息不能证明旧款 6800U。 |
| [MINISFORUM HX200：来源核查与遗留问题](https://www.nucnas.top/review/minisforum-hx200/) | 支持目录中未找到能与旧稿对应的 HX200 正式规格。 |
| [MINISFORUM HX350G：来源核查与遗留问题](https://www.nucnas.top/review/minisforum-hx350g/) | 支持目录中未找到能与旧稿对应的 HX350G 正式规格。 |
| [MINISFORUM HX80G：来源核查与遗留问题](https://www.nucnas.top/review/minisforum-hx80g/) | 支持中心有 HX80G，尚需完整产品规格；HX99G 资料不能代替。 |
| [MINISFORUM HX99G Pro：来源核查与遗留问题](https://www.nucnas.top/review/minisforum-hx99g-pro/) | 已确认 HX99G，但未确认 Pro 后缀独立规格，不能静默改成 HX99G。 |
| [MINISFORUM NAD9 Pro：来源核查与遗留问题](https://www.nucnas.top/review/minisforum-nad9-pro/) | 可检索 NAD9 资料，但缺少 NAD9 Pro 独立型号的官方证据。 |
| [MINISFORUM UM590：来源核查与遗留问题](https://www.nucnas.top/review/minisforum-um590/) | 官方历史规格入口当前不可读；翻新页浏览器标题虽提 UM590，正文和当前选项却对应 UM690，不能据此验证 UM590 的 CPU 与配置。 |
| [MINISFORUM UM790：来源核查与遗留问题](https://www.nucnas.top/review/minisforum-um790/) | 可确认 UM790 Pro，但未确定旧稿省略 Pro 是否指同一具体产品。 |
| [MINISFORUM UM800：来源核查与遗留问题](https://www.nucnas.top/review/minisforum-um800/) | 未找到能与旧稿对应的 UM800 正式规格，不以 UM890 或 UM790 替代。 |
| [MINISFORUM V7：来源核查与遗留问题](https://www.nucnas.top/review/minisforum-v7/) | 未找到能与旧稿对应的 V7 正式产品规格，不以 V3 替代。 |
| [AOOSTAR GEM12 Pro：来源核查与遗留问题](https://www.nucnas.top/review/%E5%A4%A9%E9%92%A1-gem12-pro-%E6%B5%8B%E8%AF%84%E5%B8%A6%E5%89%AF%E5%B1%8F%E7%9A%84%E5%88%9B%E6%96%B0%E8%AE%BE%E8%AE%A1/) | 已找到 GEM12 Pro 支持记录，但原稿具体 Pro/PRO MAX、CPU 和配件配置需要进一步对应。 |
| [GTX 14 Pro：来源核查与遗留问题](https://www.nucnas.top/review/zerobit-gtx-14-pro-review/) | 旧稿品牌、GTX 14 Pro 型号和 CPU 缺少可对应的正式产品文档；不能借用 Beelink GTi14 资料。 |

## 发布状态

PR、提交、CI 与正式 Cloudflare 部署证据将在完成后补入本地维护日志与本报告。
