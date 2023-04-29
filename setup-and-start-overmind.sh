#!/bin/bash

jo \
    AccountTag="$ACCOUNT_TAG" \
    TunnelSecret="$TUNNEL_SECRET" \
    TunnelID="$TUNNEL_ID" \
    TunnelName="$TUNNEL_NAME" \
    > "/etc/cloudflared/$TUNNEL_ID.json"

# cat /etc/cloudflared/$TUNNEL_ID.json

sed "1,2s/TUNNEL_ID/${TUNNEL_ID}/" < /app/cf-config.yml > /etc/cloudflared/config.yml
exec /usr/sbin/overmind start -N -f /etc/procfile.d/Procfile -r web,tunnel
