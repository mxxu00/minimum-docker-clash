# minimum-docker-clash

用于在本地快速部署 [Clash](https://github.com/Dreamacro/clash) 核心以及 [yacd](https://github.com/haishanh/yacd) 可视化面板的 Docker 脚本集合。通过 `install.sh` 可一键拉取镜像、启动容器，并完成常用代理别名的自动注入。

## 目录结构

- `install.sh`：首次部署与启动脚本，同时会调用 `update.sh` 并写入常用 Shell 别名。
- `update.sh`：根据 `config/clash_url` 指定的订阅链接下载 `config.yaml`，并自动打开 `allow-lan` 配置。
- `config/`：存放 Clash 所需的配置文件与缓存数据。`.gitignore` 默认忽略敏感文件。

## 使用前准备

1. 安装并配置好 Docker。
2. 将 Clash 订阅链接写入 `config/clash_url`。

## 快速开始

```bash
cd ./docker-clash
source install.sh
```

执行脚本后将完成以下动作：

- 拉取 `dreamacro/clash` 与 `haishanh/yacd` 镜像。
- 调用 `update.sh` 下载最新的 `config.yaml`，并将 `allow-lan` 自动设置为 `true`。
- 启动 `myclash`（Clash 核心，监听本地 `7890/9090`）与 `myclash_dashboard`（yacd 面板，映射至 `9091`）。
- 在当前用户的 `~/.bashrc` 中写入 `proxy_on`、`proxy_off`、`clash_on`、`clash_off` 等常用 alias（若别名已存在则跳过）。

访问面板：浏览器打开 `http://ip:9091`，输入 `http://ip:9090` 作为 Clash 控制端口即可管理节点与策略。

## 更新配置

如果需要更新订阅（如节点变更或想刷新配置），只需执行：

```bash
source update.sh
```

`update.sh` 会按照 `config/clash_url` 中的订阅链接，重新下载最新的 `config.yaml` 配置文件，并自动将 `allow-lan` 设为 `true`。  
执行脚本同时会自动删除并重新启动 `myclash` 容器，无需手动重启，新的配置会立即生效。

## 常用操作

- `clash_on` / `clash_off`：启动或停止 Clash 与 yacd 容器。
- `proxy_on` / `proxy_off`：开启或关闭系统级 HTTP/HTTPS 代理（指向 `127.0.0.1:65488`）。