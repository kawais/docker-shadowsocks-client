
```
sudo docker run -d --restart=yes \
                 -e SERVER=<your-server> \
                 -e SERVER_PORT=<port> \
                 -e LOCAL_PORT=1080 \
                 -e PASSWORD=<your-password> \
                 -p 8118:8118 kawais/shadowsocks-client
```


LOCAL_PORT is ss port, 8118 is privoxy port, http proxy on 8118

