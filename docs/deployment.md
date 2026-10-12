# 构建、发布与回退

核对日期：2026-10-11。本站保持 Hugo + GitHub + Cloudflare Pages。此说明区分仓库配置和需要账户权限确认的控制台设置，不代表已进行生产回退演练。

## 构建基线与依赖

- CI使用Hugo **0.147.7**，下载包有SHA-256校验；源码完整检出以支持Git更新时间。本机Hugo 0.152.2检查是补充，最终以生产版本CI为准。
- 构建命令 `hugo --minify`，输出目录 `public`。`cloudflare.toml`仅为参考，不自动设置Pages；控制台中的生产分支、HUGO_VERSION和输出目录需与此核对。
- CSS/JS由Hugo资源管线处理，没有调用PostCSS/Tailwind。2026-10-12确认构建和模板均未引用后，移除了五个闲置开发依赖及两份配置；保留npm构建快捷命令和锁文件。
- 清理前审计为9项，清理后以 `npm ci --ignore-scripts` 和 `npm audit --package-lock-only --json` 验证。npm依赖树已为空；这不代表Hugo、Actions或页面外部脚本的全面安全认证。RAID页面现有Alpine CDN脚本保留。
- 恢复或新增npm工具时必须同时提交锁文件、核查安全公告，并运行构建及链接检查。

## 本地与PR验收

在仓库目录执行：

```sh
hugo --minify
python scripts/verify_site.py
python scripts/test_local_rag.py
python scripts/audit_links.py public
git diff --check
```

链接审计现已纳入CI；没有生成HTML、缺失站内目标或片段都会使检查失败。当前检查19个关键入口、381条搜索索引、分页canonical、JSON-LD、robots/sitemap和文章纠错URL。数字随文章增减变化，不能为匹配旧数量删除新内容。

先检查main和开放PR，在独立分支修改，不覆盖用户变更。创建PR，确认针对当前head SHA的build与Cloudflare检查通过。预览域需核实不被索引；生产站不能意外加noindex。无权限查控制台时记录限制，不宣称已核对其配置。

浏览器检查320/390px及桌面：正文和表格无页面横向溢出，系列导航容纳全部条目；Tab焦点可见，菜单Enter打开、Escape关闭并返回焦点，跳到正文有效，代码框可用方向键滚动。搜索测试NAS/Ollama、无结果及空查询。现有第三方统计保持原状，未新增追踪。

## 发布后核验

1. 合并时限制预期head SHA，记录PR与合并提交；等待生产部署成功。
2. 用正式URL检查www/裸域首页、搜索、index.json、/posts/、robots、sitemap、变更文章及下载资源。检查正文标记和资源指纹，不能只看HTTP 200。
3. CDN尚在更新时保留初次结果，再复核正常URL。查询参数探测不能代替最终正常地址验收。
4. 记录状态、commit、检查链接、页面标记、截图及遗留项。无证据不报告性能或流量提升。

裸域跳转、DNS、托管、收费功能或重大权限变更需用户另行决定。本流程不会自动修改这些设置。

## 故障与回退

关键路由报错、搜索失效、明显布局破坏或内容严重错误时，先保存故障URL、时间、提交和截图，确认是否仅缓存、网络或客户端差异。

**恢复线上：** 有相应权限时，在Cloudflare Pages的Deployments中选择已验证成功的生产部署，使用“Rollback to this deployment”并核对提交。预览部署不是回退目标。随后重做正式站路由和内容验收；没有权限则报告需要账户所有者完成的具体步骤。[官方说明](https://developers.cloudflare.com/pages/configuration/rollbacks/)

**同步修正Git：** 平台回退不等于修改main。另建修复分支，用 `git revert <已确认的错误提交>` 生成可审查的撤销提交，保护后续用户变更；逐项解决冲突，不硬重置main或强推。PR检查通过再合并，避免下次部署重新带入错误。单点问题可优先提交针对性修复，避免撤销整个批次。

本轮核对了回退文档与历史成功部署证据，**未故意把生产站切回旧版**。操作前仍需核实权限、目标版本和期间新内容。源码或静态页回退不能撤销DNS、权限或第三方服务中的外部修改。

## 后续配置事项

仅对带内容指纹的资源考虑长缓存；HTML与搜索索引需及时更新。CSP如需引入，先用报告模式盘点内联脚本和现有统计再逐项验证。相似文章逐项判断，不为清零检查批量删除。
