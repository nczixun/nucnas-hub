---
title: "2026��NAS��װDockerӦ���Ƽ�������˽����������"
date: 2026-03-05
categories: ["nas"]
tags: ["NAS", "Docker", "˽����", "Ӧ���Ƽ�", "Docker Compose"]
platform: "nas"
slug: "nas-docker-apps-recommend-2026-v3"
---

# 2026��NAS��װDockerӦ�ã���20��Ӧ�������˽���Ƹ�ǿ��


**�������ڣ�** 2026��3��5��

## һ��ǰ��

<a href="/guide/docker-best-practice/" target="_blank">Docker</a>��<a href="/nas/" target="_blank">NAS</a>�����淨�ĺ��ġ�����<a href="/guide/docker-best-practice/" target="_blank">Docker</a>���������<a href="/nas/" target="_blank">NAS</a>�����и��ַ��񣬴��ļ���������ܼҾӣ���Ӱ�����ֵ�AIӦ�á����ľ�ѡ20���ر�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>Ӧ�ã������<a href="/nas/" target="_blank">NAS</a>�ﳬ��ֵ��

## �����ر�������

### 2.1 <a href="/guide/nas-docker-apps-recommend-2026-v3/" target="_blank">Portainer</a>�����������

```yaml
version: '3'
services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: unless-stopped
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data
```

**����**��ͼ�λ�<a href="/guide/docker-best-practice/" target="_blank">Docker</a>������壬���ӻ������������������

**�Ƽ�����**����װ������<a href="/guide/docker-best-practice/" target="_blank">Docker</a>��ֱ��

### 2.2 FileBrowser���ļ������

**����**����ҳ���ļ���������֧����ק�ϴ�������Ԥ����Ȩ�޹���

**�������**��<a href="/guide/alist-network-aggregation-2026/" target="_blank">Alist</a>�����̾ۺϣ�

### 2.3 Nginx Proxy Manager����������

**����**��ͼ�λ����÷�������֧��Let's Encrypt�Զ�SSL֤��

**�Ƽ�����**��������͸���������ʱر�

## ����Ӱ��������

### 3.1 Jellyfin��ý���������

**����**���Խ�Ӱ�ӿ⣬֧�ֺ���ǽ��Ӳ��ת�롢Զ�̷���

**�Ƽ�����**��
```yaml
jellyfin:
  image: jellyfin/jellyfin:latest
  container_name: jellyfin
  restart: unless-stopped
  environment:
    - TZ=Asia/Shanghai
  volumes:
    - ./config:/config
    - ./cache:/cache
    - /path/to/media:/media
  ports:
    - "8096:8096"
    - "8920:8920"
```

### 3.2 Bazarr����Ļ���أ�

**����**���Զ����ص�Ӱ/�缯��Ļ��֧�ֶ�����

**���**��Jellyfin/Plex

### 3.3 qBittorrent�����أ�

**����**��BT/PT���أ�֧���Զ�RSS����

**�Ƽ�����**��Jackett��������

## �ġ���Ƭ������

### 4.1 <a href="/guide/immich-photo-cloud/" target="_blank">Immich</a>��AI��ᣩ

**����**��Google Photos��Դ�����AI����ʶ�𡢵�ͼ��ͼ������ͬ��

**����**��
- �ƶ���App֧��
- AI����ʶ��
- ����λ��չʾ
- �Զ������ֻ���Ƭ

### 4.2 PhotoPrism��AI��ᣩ

**����**����һ��ǿ���AI��ᣬ֧������ʶ�𡢵���ʶ��

**�Ա�**��<a href="/guide/immich-photo-cloud/" target="_blank">Immich</a>��ע���ƶ������飬PhotoPrism��ҳ���ܸ��ḻ

## �塢���ܼҾ���

### 5.1 <a href="/guide/home-assistant-nuc/" target="_blank">Home Assistant</a>

**����**����Դ���ܼҾ�ƽ̨��֧����ǧ���豸

**�Ƽ�����**��ʹ��OS�汾ͨ��KVM/Proxmox���У����ܸ���

**��װ���**��
- HACS����������̵꣩
- ESPHome��DIY�豸��
- Node-RED���Զ�����

### 5.2 AdGuard Home�������ˣ�

**����**��ȫ��������أ�DNS���ˣ�������������

**�Ƽ�����**����·���������˸�ǿ��

## ����Ч�ʹ�����

### 6.1 Syncthing���ļ�ͬ����

**����**�����豸�ļ�ͬ��������ٶ�����/OneDrive

**����**����Ե���ܴ��䣬���ߵ�����������

### 6.2 Wallabag���Ժ��Ķ���

**����**����Դ�Ժ��Ķ����ղ��������߲鿴

### 6.3 LinkStack�����˵���ҳ��

**����**���Խ���ַ����������Linktree

### 6.4 Uptime Kuma����أ�

**����**���Խ���վ/�����أ�֧�ָ澯֪ͨ

## �ߡ�AI/������

### 7.1 <a href="/ai/ollama-beginner-guide-2026/" target="_blank">Ollama</a>�����ش�ģ�ͣ�

**����**����<a href="/nas/" target="_blank">NAS</a>������Llama 2��DeepSeek�ȴ�����ģ��

**�Ƽ�����**����Ҫ16GB+�ڴ棬����N5105����CPU

### 7.2 OpenWebUI���Ի����棩

**����**��ChatGPT�����棬����<a href="/ai/ollama-beginner-guide-2026/" target="_blank">Ollama</a>������API

### 7.3 Stable Diffusion WebUI��AI�滭��

**����**������AI��ͼ�����Կ�֧��

**�Ƽ�����**��RTX 3060�����Կ�

## �ˡ�ѧϰ/������

### 8.1 CodeServer���ƶ�IDE��

**����**��������б�̣�֧��VS Code

### 8.2 PiKVM��IPKVM�����

**����**��Զ��KVM over IP��Ӳ��ά������

### 8.3 WikiJS��֪ʶ�⣩

**����**���Խ�����/�Ŷ�֪ʶ��

## �š���װ����

### 9.1 <a href="/guide/docker-best-practice/" target="_blank">Docker Compose</a>ģ��

�Ƽ�ʹ��<a href="/guide/nas-docker-apps-recommend-2026-v3/" target="_blank">Portainer</a>��"Stacks"���ܻ�<a href="/guide/docker-best-practice/" target="_blank">Docker Compose</a>����

### 9.2 ��Դ����

| Ӧ�� | CPU | �ڴ� |
| :--- | :--- | :--- |
| Jellyfin | 2��+ | 4GB+ |
| Home Assistant | 1�� | 2GB |
| <a href="/guide/immich-photo-cloud/" target="_blank">Immich</a> | 2�� | 4GB+ |
| <a href="/ai/ollama-beginner-guide-2026/" target="_blank">Ollama</a> | 4�� | 16GB+ |

### 9.3 ���ݳ־û�

��Ҫ����ʹ��volumeӳ�䣬������װ����ʧ��
```yaml
volumes:
  - ./data:/app/data
  - /mnt/storage:/storage
```

## ʮ���ܽ�

��20��<a href="/guide/docker-best-practice/" target="_blank">Docker</a>Ӧ�ú�����<a href="/nas/" target="_blank">NAS</a>�ķ������棺

- **������**��<a href="/guide/nas-docker-apps-recommend-2026-v3/" target="_blank">Portainer</a>��Nginx PM��FileBrowser
- **Ӱ����**��Jellyfin��Bazarr��qBittorrent
- **�����**��<a href="/guide/immich-photo-cloud/" target="_blank">Immich</a>��PhotoPrism
- **�Ҿ���**��<a href="/guide/home-assistant-nuc/" target="_blank">Home Assistant</a>��AdGuard
- **Ч����**��Syncthing��Wallabag
- **AI��**��<a href="/ai/ollama-beginner-guide-2026/" target="_blank">Ollama</a>��OpenWebUI

**��װ����**���Ӽ�Ӧ�ÿ�ʼ�������롣<a href="/guide/docker-best-practice/" target="_blank">Docker</a>��<a href="/nas/" target="_blank">NAS</a>������Ϊ���������ߣ�

**��ؽ̳�**��
- [<a href="/guide/docker-best-practice/" target="_blank">NAS Docker����ָ��</a>](/guide/docker-best-practice/)
- [<a href="/guide/home-assistant-nuc/" target="_blank">Home Assistant��װ����</a>](/guide/home-assistant-nuc/)

---

*�����������ע [NASѧԺ](/nas/)��*

<div class="page-nav">
  <a href="/guide/nas-beginner-guide-2026/" rel="prev">��һҳ��NAS������ȫָ�ϣ�2026����㿪ʼ�������˽����</a>
</div>

*������ NUC NAS Hub �Զ�����*
