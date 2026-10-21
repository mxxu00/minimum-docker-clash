# docker pull metacubex/mihomo
# docker pull haishanh/yacd

# source update.sh

# docker run -d --name myclash --restart always -v ./config:/root/.config/mihomo -p 65488:7890 -p 9090:9090 metacubex/mihomo
# docker run -d --name yacd --restart unless-stopped -p 8080:80 haishanh/yacd

# 将以下别名添加到~/.bashrc中
grep -qxF "alias proxy_on='export http_proxy=http://127.0.0.1:65488 && export https_proxy=http://127.0.0.1:65488'" ~/.bashrc || echo "alias proxy_on='export http_proxy=http://127.0.0.1:65488 && export https_proxy=http://127.0.0.1:65488'" >> ~/.bashrc
grep -qxF "alias proxy_off='unset http_proxy && unset https_proxy'" ~/.bashrc || echo "alias proxy_off='unset http_proxy && unset https_proxy'" >> ~/.bashrc
