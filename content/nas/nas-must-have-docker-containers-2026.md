---
title: "NAS Docker 应用怎么选：先按用途安装"
date: 2026-03-06
categories: ["nas"]
summary: "从容器管理、媒体播放和照片管理三个常见需求出发，选择 NAS 上的 Docker 应用，并在安装前核对数据卷、备份与访问边界。"
tags: ["Docker", "NAS", "container"]
slug: "nas-must-have-docker-containers-2026"
contentStatus: "reviewed"
reviewedAt: "2026-10-29"
---

# NAS Docker 应用怎么选：先按用途安装

Docker 应用没有一张适用于所有 NAS 的“必装清单”。先确定要解决的问题，再核对 NAS 系统、处理器架构、存储路径和维护方式。刚开始时一次只部署一个应用，确认数据能持久保存、能备份和恢复，再添加下一个。

## 按用途挑选

| 需求 | 可以了解的项目 | 安装前先确认 |
| --- | --- | --- |
| 管理容器 | [Portainer](https://docs.portainer.io/start/install-ce) | 当前 NAS 系统支持的安装方式；管理面板只开放给可信的管理网络。 |
| 家庭媒体库 | [Jellyfin](https://jellyfin.org/docs/general/installation/) | NAS 系统与硬件是否受支持；媒体目录是否以只读或最小必要权限挂载。 |
| 照片备份与浏览 | [Immich](https://docs.immich.app/install/requirements/) | 运行环境、存储和数据库要求；照片原件与数据库都纳入备份及恢复计划。 |

这些是按场景列出的候选项目，不代表已在各品牌 NAS 上实测，也不构成兼容性或性能保证。项目官方安装文档会随版本更新；请以安装当天的对应说明、镜像架构和 NAS 厂商支持范围为准。

## 安装前的四项检查

1. **确认来源和版本。** 从项目官方文档或官方镜像入口进入，检查镜像发布者、支持的 CPU 架构和版本说明。不要只凭名称相似就运行第三方镜像。
2. **把持久数据放在明确的存储位置。** Docker 官方文档说明，容器可写层中的数据在容器被销毁后不会保留；需要持久化的数据可使用卷、绑定挂载等方式存放在容器之外。记下每个容器的主机路径、容器路径和读写权限。
3. **先制定备份和恢复办法。** 配置、数据库、上传文件和媒体原件可能分别位于不同目录或卷。备份覆盖哪些数据、应用停止或一致性快照的要求，以及如何恢复，都应按应用文档确认。RAID/快照不能代替独立备份。
4. **控制管理入口。** 不应将 Docker daemon 远程接口直接暴露给不可信网络。Docker 官方警告，未妥善保护的远程访问可能使未授权用户取得主机高权限；远程管理应先按官方安全文档配置保护。

## 建议的上手顺序

1. 先在 NAS 上建立专用目录，确认共享权限及可用空间。
2. 阅读项目当前安装说明，按 NAS 系统选择部署方式；不要照搬针对其他系统的路径、用户 ID、设备映射或端口配置。
3. 部署单个应用后，检查日志、健康状态、登录权限和数据是否写入预期目录。
4. 用少量测试数据验证升级、重建容器和恢复流程，再迁入重要数据。
5. 记录项目名称、镜像与版本、卷映射、端口和备份位置，便于以后维护。

Docker 官方文档说明，卷由 Docker 管理并保存在主机文件系统中；卷可在使用它的容器被移除后继续保留数据，但这仍不是独立的异地或离线备份。可继续阅读 [NAS Docker 管理最佳实践](/guide/docker-best-practice/) 与 [NAS 阅读路线](/nas-roadmap/)。

## 官方资料

- [Docker：容器数据存储](https://docs.docker.com/engine/storage/)
- [Docker：卷](https://docs.docker.com/engine/storage/volumes/)
- [Docker：远程访问 daemon 的安全说明](https://docs.docker.com/engine/daemon/remote-access/)
- [Portainer CE 安装文档](https://docs.portainer.io/start/install-ce)
- [Jellyfin 安装文档](https://jellyfin.org/docs/general/installation/)
- [Immich 安装要求](https://docs.immich.app/install/requirements/)
