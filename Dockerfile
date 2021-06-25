FROM python:3-alpine
ADD ./shadowsocks-master.zip /shadowsocks-master.zip
RUN echo 'http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
    && apk add -U  libsodium privoxy \
    &&  pip install /shadowsocks-master.zip -U \
    && rm -rf /var/cache/apk/*

ENV SERVER 0.0.0.0
ENV SERVER_PORT 998
ENV LOCAL_PORT 1080
ENV LOCAL_ADDR 127.0.0.1
ENV PASSWORD default
ENV METHOD aes-256-gcm
ENV TIMEOUT 300

EXPOSE $LOCAL_PORT

RUN mv /etc/privoxy/config.new /etc/privoxy/config \
    && mv /etc/privoxy/default.filter.new /etc/privoxy/default.filter \
    && mv /etc/privoxy/default.action.new /etc/privoxy/default.action \
    && mv /etc/privoxy/match-all.action.new /etc/privoxy/match-all.action \
    && mv /etc/privoxy/user.filter.new /etc/privoxy/user.filter \
    && mv /etc/privoxy/user.action.new /etc/privoxy/user.action \
    && echo "forward-socks5 / 127.0.0.1:1080 ." >> /etc/privoxy/config \
    && sed -i 's/listen-address  127.0.0.1:8118/listen-address  0.0.0.0:8118/g' /etc/privoxy/config 

CMD nohup privoxy --no-daemon /etc/privoxy/config & sslocal -s "$SERVER" \
    -p "$SERVER_PORT" \
    -l "$LOCAL_PORT" \
    -b "$LOCAL_ADDR" \
    -k "$PASSWORD" \
    -m "$METHOD" \
    -t "$TIMEOUT" \
    -vv
