FROM alpine

ARG S6_OVERLAY_VERSION=3.1.4.2

RUN apk --update add --no-cache wget jo bash xz

# Only used as the demo app - you can remove this
RUN apk --update add --no-cache nginx

RUN wget -q https://github.com/cloudflare/cloudflared/releases/download/2021.8.1/cloudflared-linux-amd64 && \
    chmod +x cloudflared-linux-amd64 && \
    mkdir -p /bin && \
    mv cloudflared-linux-amd64 /bin/cloudflared

ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
RUN tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

COPY ./docker/services.d /etc/services.d/
COPY ./docker/cont-init.d /etc/cont-init.d/
COPY ./docker/bin/wait-for-it /bin/wait-for-it
COPY ./docker/nginx/config/nginx.conf /etc/nginx/http.d/default.conf
COPY ./docker/nginx/content/index.html /var/www

ENTRYPOINT [ "/init" ]
