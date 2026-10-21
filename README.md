# minimum-docker-clash

用于在本地快速部署 [mihomo](https://github.com/MetaCubeX/mihomo)（原 Clash.Meta 内核）以及 [yacd](https://github.com/haishanh/yacd) 可视化面板的 Docker 脚本集合。通过 `update.sh` 一键下载订阅并启动内核，`install.sh` 负责写入常用代理别名。

## 目录结构

- `install.sh`：命令备忘（镜像拉取与容器启动，见文件头部注释），并向 `~/.bashrc` 写入 `proxy_on` / `proxy_off` 别名。
- `update.sh`：根据 `config/clash_url` 指定的订阅链接下载 `config.yaml`，自动打开 `allow-lan`，并（重新）启动 mihomo 容器。
- `config/`：存放 mihomo 所需的配置文件与缓存数据。`.gitignore` 默认忽略敏感文件。

## 使用前准备

1. 安装并配置好 Docker。
2. 将 Clash 订阅链接写入 `config/clash_url`。

## 快速开始

```bash
docker pull metacubex/mihomo
docker pull haishanh/yacd

source update.sh

docker run -d --name yacd --restart unless-stopped -p 8080:80 haishanh/yacd

source install.sh
```

执行后将完成以下动作：

- 拉取 `metacubex/mihomo` 与 `haishanh/yacd` 镜像。
- 调用 `update.sh` 下载最新的 `config.yaml`（`allow-lan` 自动设置为 `true`），并启动 `myclash`（mihomo 内核，代理端口映射至本地 `65488`，API 端口 `9090`）。
- 启动 `yacd`（可视化面板，映射至本地 `8080`）。
- 在当前用户的 `~/.bashrc` 中写入 `proxy_on`、`proxy_off` 别名（若别名已存在则跳过）。

访问面板：浏览器打开 `http://ip:8080`，后端地址填 `http://ip:9090` 即可管理节点与策略。

两个容器分别配置了 `--restart always` / `unless-stopped`，开机或 Docker 重启后会自动拉起，无需手动启停。

## 更新配置

如果需要更新订阅（如节点变更或想刷新配置），只需执行：

```bash
source update.sh
```

`update.sh` 会按照 `config/clash_url` 中的订阅链接，重新下载最新的 `config.yaml` 配置文件，并自动将 `allow-lan` 设为 `true`。  
执行脚本同时会自动删除并重新启动 `myclash` 容器，无需手动重启，新的配置会立即生效。

## 常用操作

- `proxy_on` / `proxy_off`：开启或关闭系统级 HTTP/HTTPS 代理（指向 `127.0.0.1:65488`）。
- 容器随 Docker 自动启动；如需手动启停，使用 `docker start/stop myclash yacd`。
