### fly-cloudflared

This is an example project which uses `docker-compose` to build a service
which runs on `fly.io`, and uses a `cloudflared tunnel` to route traffic
from a domain name hosted by Cloudflare to that service.

#### Building

Running locally:

    docker-compose build
    docker-compose up

**NOTE**: The following environmental variables will have to be set in order
for this to work. Substitute actual values for the description:

    export ACCOUNT_TAG="your-cloudflare-account-tag"
    export TUNNEL_SECRET="your-cloudflare-tunnel-secret"
    export TUNNEL_ID="your-cloudflare-tunnel-ID"
    export TUNNEL_NAME="your-cloudflare-tunnel-name"
