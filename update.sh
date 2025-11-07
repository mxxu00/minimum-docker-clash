wget -O ./config/config.yaml $(cat ./config/clash_url)

# 将 config.yaml 里的 allow-lan 改为 true
sed -i 's/^\(allow-lan:\).*/\1 true/' ./config/config.yaml

if docker ps -a --format '{{.Names}}' | grep -qw myclash; then
    docker rm -f myclash
fi

docker run -d --name myclash -v ./config:/root/.config/clash -p 65488:7890 -p 65489:9090 dreamacro/clash
