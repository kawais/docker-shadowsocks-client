#+title: Docker Shadowsocks Client
#+description: shadowsocks client in docker(based on alpine linux)
#+keywords: docker shadowsocks client 
#+startup: indent hideblocks content
#+options: ^:{} toc:t

* What is this?
Shadowsocks client in a docker container. Quickly create local shadowsocks client in 5 secs.

* How to use?
Simply run(replace related args with your custom value)

```
sudo docker run -d --restart=yes \
                 -e SERVER=<your-server> \
                 -e SERVER_PORT=<port> \
                 -e LOCAL_PORT=1080 \
                 -e PASSWORD=<your-password> \
                 -p 8118:8118 kawais/shadowsocks-client
```
LOCAL_PORT is ss port, 8118 is privoxy port, http proxy on 8118

