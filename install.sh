docker pull dreamacro/clash
docker pull haishanh/yacd

source update.sh

docker run -d --name myclash -v ./config:/root/.config/clash -p 65488:7890 -p 65489:9090 dreamacro/clash
docker run -d --name myclash_dashboard -p 9091:80 haishanh/yacd

# 将以下别名添加到~/.bashrc中
grep -qxF "alias proxy_on='export http_proxy=http://127.0.0.1:65488 && export https_proxy=http://127.0.0.1:65488'" ~/.bashrc || echo "alias proxy_on='export http_proxy=http://127.0.0.1:65488 && export https_proxy=http://127.0.0.1:65488'" >> ~/.bashrc
grep -qxF "alias proxy_off='unset http_proxy && unset https_proxy'" ~/.bashrc || echo "alias proxy_off='unset http_proxy && unset https_proxy'" >> ~/.bashrc
grep -qxF "alias clash_on='docker start myclash && docker start myclash_dashboard'" ~/.bashrc || echo "alias clashon='docker start myclash && docker start myclash_dashboard'" >> ~/.bashrc
grep -qxF "alias clash_off='docker stop myclash && docker stop myclash_dashboard'" ~/.bashrc || echo "alias clashoff='docker stop myclash && docker stop myclash_dashboard'" >> ~/.bashrc
