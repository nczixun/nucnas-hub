# Cloudflare 部署与验收

现有站点继续使用 Cloudflare；cloudflare.toml 仅供历史参考，不会自动配置 Pages。

## 构建
线上页面声明 Hugo 0.147.7。本次用相同版本验收，另以 0.167.0 做兼容性检查；建议保持 HUGO_VERSION=0.147.7，后续升级另行验证。构建命令 hugo --minify，目录 public。仓库当前纯 Hugo CSS/JS 资源管线无需 npm 执行，但保留现有依赖和锁文件。生产使用完整 Git checkout，以支持 enableGitInfo。

## 发布
1. 核对 Pages/Workers 项目、生产分支及发布 commit。先部署 PR Preview。
2. 确认裸域与 www 证书和绑定正常。保留现有 www 规范域；裸域通过 Cloudflare Redirect Rule 永久跳转，保留路径和查询。
3. 预览域使用 X-Robots-Tag: noindex，并验证生产不带该标记。
4. 检查 /、/hardware/、/nas/、/ai/、/calculator/、/search/?q=NAS、/posts/、/sitemap.xml、/index.json 以及不存在 URL。
5. 仅含内容指纹的 CSS/JS 可采用一年 immutable；HTML 沿用平台缓存策略。先核对响应头再启用覆盖规则。
6. CSP 先报告模式，收集站内工具/内联脚本/第三方统计所需来源，再逐项收紧。
7. 如失败，回滚 Cloudflare 上一成功部署；不要删除历史文章以规避测试。

## 数据与内容
邮箱订阅暂用 RSS 替代，避免假成功。需要邮箱订阅时再接入实际服务、错误反馈和退订流程。
未设置 score 的文章显示“暂未评分”，已有评分需由编辑补充实测依据。
分析平台 ID 保持原值；停用任何一方前应对照实际数据需求。
相似内容先结合收录、流量和全文决定主文；不能只按文件名批量删除或重定向。

