#!/bin/sh
jo \
    AccountTag="$ACCOUNT_TAG" \
    TunnelSecret="$TUNNEL_SECRET" \
    TunnelID="$TUNNEL_ID" \
    TunnelName="$TUNNEL_NAME" \
    > "/etc/cloudflared/$TUNNEL_ID.json"

cat /etc/cloudflared/$TUNNEL_ID.json
