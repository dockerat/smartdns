FROM pikuzheng/smartdns AS dns

FROM ccr.ccs.tencentyun.com/storezhang/alpine:3.20.0 AS builder

COPY docker /docker
COPY --from=dns /usr/sbin/smartdns /docker/usr/sbin/smartdns

RUN chmod +x /docker/etc/s6/inotify/*
RUN chmod +x /docker/etc/s6/smartdns/*



# 打包真正的镜像
FROM ccr.ccs.tencentyun.com/storezhang/alpine:3.20.0


LABEL author="storezhang<张宗良>" \
    email="storezhang@gmail.com" \
    qq="160290688" \
    wechat="storezhang" \
    description="指定文件后，根据配置文件是否有变化来决定是否重启程序达到随时解析更新"


COPY --from=builder /docker /


RUN set -ex \
    \
    \
    \
    && apk update \
    \
    && apk add --no-cache inotify-tools \
    \
    \
    \
    && rm -rf /var/cache/apk/*


ENV SMARTDNS_HOME ${USER_HOME}
ENV CONFIG_HOME ${SMARTDNS_HOME}/work
ENV CONFIG_FILEPATH ${SMARTDNS_HOME}/work/dns.conf
