FROM docker:17.09.0
LABEL maintainer="Bogdan Dodoiu <bdodoiu@gmail.com>" \
      description="Based on docker image with docker-compose on top. Useful for Gitlab runner jobs for deployment"

ENV GLIBC 2.23-r3
ARG COMPOSE_VERSION=1.17.0

RUN apk update && apk add --no-cache openssl ca-certificates && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC/glibc-$GLIBC.apk && \
    apk add --no-cache glibc-$GLIBC.apk && rm glibc-$GLIBC.apk && \
    ln -s /lib/libz.so.1 /usr/glibc-compat/lib/ && \
    ln -s /lib/libc.musl-x86_64.so.1 /usr/glibc-compat/lib && \
    wget -q -O /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` && \
    chmod +x /usr/local/bin/docker-compose 

