---
slug: "immich-photo-cloud"
title: "Immich：替代 Google Photos 的私有照片方案"
date: 2026-02-12
summary: "像原厂 App 一样流畅，支持 AI 人脸识别。"
categories: ["nas"]
---

# Immich：替代 Google Photos 的私有照片方案

在这个手机摄影爆炸的时代，每个家庭的照片数量都在飞速增长。宝宝成长的点滴、旅行中的风景、日常生活的小确幸——这些定格的瞬间承载着无可替代的记忆。然而，将照片完全托付给Google Photos或iCloud存在隐私风险，云存储的容量焦虑也时刻困扰着我们。部署一套私有照片管理方案，成为越来越多家庭用户的需求。

Immich正是为解决这个痛点而生的开源项目。它旨在提供与Google Photos相似的使用体验——流畅的浏览、智能的分类、便捷的分享——同时保证所有数据都存储在自己的NAS上。本文将详细介绍Immich的功能特性、Docker部署步骤以及最佳实践，帮助你搭建属于自己的私有云相册。

## 为什么选择Immich

在Immich之前，PhotoStation（群晖）、Piwigo、Nextcloud Photos等方案已经存在。但它们要么依赖特定的NAS系统，要么体验与Google Photos相差甚远。Immich的出现改变了这个格局。

首先，Immich采用了与Google Photos高度相似的设计语言。底部导航栏、时间轴浏览、缩略图网格、右滑切换——这些交互细节都让人感到无比熟悉。对于从Google Photos迁移过来的用户，学习成本几乎为零。

其次，Immich的核心功能完全免费且开源。你不需要购买群晖昂贵的Drive套件，也不用担心云服务商涨价或服务变更。所有功能都开放给你，可以自建、可以fork、可以私有化部署。

第三，Immich的性能非常出色。相比Nextcloud相册的加载缓慢，Immich的缩略图生成和图片浏览可以用"丝滑"来形容。即使是上万张照片的图库，滑动浏览也几乎感受不到卡顿。这得益于它采用了现代化的技术栈和高效的缩略图缓存策略。

最后，Immich的移动端体验同样优秀。官方提供iOS和Android客户端，支持后台自动备份手机相册。即使你同时使用iPhone和Android手机，也可以统一备份到一个NAS账号。

## 核心功能一览

Immich的功能可以分为以下几个模块：

**照片浏览**：支持按时间轴、设备、相册等多种方式浏览。时间轴模式自动按拍摄日期排列，设备模式可以查看不同手机拍摄的照片，相册模式则支持用户自定义相册和收藏夹。缩略图采用渐进式加载，原图按需下载，节省流量和加载时间。

**AI功能**：Immich内置了机器学习引擎，支持人脸识别、物体识别、场景分类和地理地点识别。人脸识别可以自动将同一人物的照片聚合，方便快速找到某人的所有照片；物体识别可以识别照片中的物体、宠物、食物等；地理地点识别则会在地图上标注照片的拍摄位置。

**备份同步**：移动端App支持后台自动备份新拍摄的照片。可以选择仅在WiFi环境下备份，也可以设置仅备份特定相册。备份进度清晰可见，支持断点续传。

**分享协作**：可以创建公开链接分享照片，也可以邀请家庭成员加入成为"家庭成员"，共享照片库的同时保留各自的隐私空间。分享功能还支持设置密码和过期时间。

**管理后台**：管理员可以管理用户账户、存储空间、服务器设置等。可以看到每个用户的存储使用量，支持批量操作。

## Docker部署详细教程

Immich官方推荐使用Docker Compose部署，这是在NAS上运行的最佳方式。以下是完整的部署步骤：

第一步，创建部署目录。在NAS上创建一个文件夹用于存放Immich的配置和数据，例如`/docker/immich`。

第二步，创建docker-compose.yml文件。内容如下：

```yaml
version: '3.8'

services:
  immich:
    image: ghcr.io/immich-app/immich-server:latest
    command: ['start.sh', 'immich']
    ports:
      - '2283:3001'
    volumes:
      - ./upload:/usr/src/app/upload
      - /etc/localtime:/etc/localtime:ro
    environment:
      - DB_HOSTNAME=immich_db
      - DB_USERNAME=postgres
      - DB_PASSWORD=postgres
      - DB_DATABASE_NAME=immich
      - REDIS_HOSTNAME=immich_redis
    depends_on:
      - immich_db
      - immich_redis
    restart: unless-stopped

  immich_microservices:
    image: ghcr.io/immich-app/immich-server:latest
    command: ['start.sh', 'microservices']
    volumes:
      - ./upload:/usr/src/app/upload
      - /etc/localtime:/etc/localtime:ro
    environment:
      - DB_HOSTNAME=immich_db
      - DB_USERNAME=postgres
      - DB_PASSWORD=postgres
      - DB_DATABASE_NAME=immich
      - REDIS_HOSTNAME=immich_redis
    depends_on:
      - immich_db
      - immich_redis
    restart: unless-stopped

  immich_machine_learning:
    image: ghcr.io/immich-app/immich-machine-learning:latest
    volumes:
      - ./model-cache:/cache
    restart: unless-stopped

  immich_db:
    image: tensorchord/pgvecto-rs:pg14-v0.2.0
    environment:
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_USER=postgres
      - POSTGRES_DB=immich
    volumes:
      - ./pgdata:/var/lib/postgresql/data
    restart: unless-stopped

  immich_redis:
    image: redis:6.2-alpine
    restart: unless-stopped

volumes:
  pgdata:
  model-cache:
```

这个配置文件定义了5个服务：主服务器、微服务（负责AI任务）、机器学习（负责人脸识别等）、数据库（PostgreSQL）和Redis缓存。其中机器学习服务对硬件要求较高，如果你的NUC没有GPU，可以跳过这一步，Immich仍能正常运行，只是AI功能会受限。

第三步，启动服务。在存放docker-compose.yml的目录执行：

```bash
docker-compose up -d
```

首次启动会拉取镜像并初始化数据库，需要等待3-5分钟。

第四步，访问Immich。打开浏览器输入`http://NAS-IP:2283`，使用默认管理员账户`admin@immich.app`登录（首次登录后建议立即修改密码）。

## 移动端配置与自动备份

Immich的移动端App可以从GitHub Releases页面下载（iOS需要TestFlight或自签名）。安装完成后，按照以下步骤配置：

打开App，点击"Login to Server"，输入你的NAS地址（如果启用了HTTPS则输入https://地址），然后使用管理员账户登录。首次登录会要求绑定设备，可以选择设置为管理员账户。

备份设置中，可以开启"Auto Backup"并选择需要备份的相册。建议设置为仅在WiFi环境下备份，避免消耗手机流量。备份目标可以选择上传到管理员账户或创建个人账户供自己使用。

现在，每次拍摄新照片后，Immich会在后台自动同步到你的NAS。你不再需要担心手机存储空间不足，也不用担心照片泄露。

## AI功能配置与优化

Immich的AI功能是其核心竞争力之一。默认配置下，人脸识别、物体识别等服务会自动运行，但你可以通过环境变量进行优化。

如果你的NUC有NVIDIA显卡（消费级GTX/RTX系列即可），可以启用GPU加速，大幅提升AI处理速度。在docker-compose.yml中添加：

```yaml
environment:
  - NVIDIA_VISIBLE_DEVICES=all
deploy:
  resources:
    reservations:
      devices:
        - driver: nvidia
          count: 1
          capabilities: [gpu]
```

对于仅使用CPU的用户，AI处理速度会较慢，首次导入大量照片时可能需要等待数小时。可以调整微服务的并发数来提升效率，但要注意不要把CPU跑满导致NAS其他服务卡顿。

## 数据迁移与备份

如果你之前使用Google Photos，可以通过Google Takeout导出全部照片，然后在Immich中使用"原图导入"功能批量上传。上传完成后，AI识别会自动运行，重新整理照片。

对于Immich本身的数据备份，推荐使用NAS的Hyper Backup或rsync定期备份`/docker/immich`目录。其中最重要的是`upload`文件夹（存放所有照片原图）和`pgdata`文件夹（存放数据库）。如果NAS系统崩溃，只需将这两个文件夹恢复到新设备，Immich就能完全恢复运行。

## 总结

Immich是目前NAS上最接近Google Photos体验的私有照片管理方案。它既有现代化的界面设计，又有强大的AI识别能力，还支持多平台同步和分享。对于注重隐私、不满云相册限制、想要完全掌控自己数据的用户来说，Immich无疑是最值得部署的应用。

更重要的是，当你看着NAS硬盘里整齐排列的照片，当家人可以随时随地浏览全家的珍贵回忆，当那些定格的瞬间不再受制于任何云服务——你会明白，拥有一个自己的"私有Google Photos"，是这个数字时代最值得的投资。
