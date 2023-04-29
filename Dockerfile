FROM alpine

ARG OVERMIND_VERSION=v2.4.0

ENV ACCOUNT_TAG=$ACCOUNT_TAG
ENV TUNNEL_SECRET=$TUNNEL_SECRET
ENV TUNNEL_ID=$TUNNEL_ID
ENV TUNNEL_NAME=$TUNNEL_NAME

RUN apk --update add --no-cache wget bash jo tmux

# Only used as the demo app - you can remove this
RUN apk --update add --no-cache nginx

RUN wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x cloudflared-linux-amd64 && \
    mkdir -p /bin && \
    mv cloudflared-linux-amd64 /bin/cloudflared

ADD https://github.com/DarthSim/overmind/releases/download/${OVERMIND_VERSION}/overmind-${OVERMIND_VERSION}-linux-amd64.gz /tmp
RUN gzip -d < /tmp/overmind-${OVERMIND_VERSION}-linux-amd64.gz > /usr/sbin/overmind
RUN chmod 755 /usr/sbin/overmind

RUN mkdir -p /etc/procfile.d
COPY ./Procfile /etc/procfile.d
COPY ./docker/nginx/config/nginx.conf /etc/nginx/http.d/default.conf
COPY ./docker/nginx/content/index.html /var/www

RUN mkdir -p /etc/cloudflared
RUN mkdir /app
COPY ./cloudflared-setup.sh /app/cloudflared-setup.sh
COPY ./cf-config.yml /app/cf-config.yml
COPY ./setup-and-start-overmind.sh /app/setup-and-start-overmind.sh
RUN chmod 755 /app/setup-and-start-overmind.sh

CMD "/app/setup-and-start-overmind.sh"
