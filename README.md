### fly-cloudflared

This is an example project which *used to* use `docker-compose` to build a service
which runs on `fly.io`, and uses a `cloudflared tunnel` to route traffic
from a domain name hosted by Cloudflare to that service.

Except it never actually *worked* with `fly.io`, since they don't support
`docker-compose`, since they don't actually run `docker`!

Instead, you can set up a process manager, set it up to run, and then all the
processes it starts will be run on the `fly.io` server. There is
[extensive documentation](https://fly.io/docs/app-guides/multiple-processes/) 
on the `fly.io` website to show you a lot of options for doing this. Notably, the 
process manager *can not* run as PID 1, which rules out (e.g.) the `s6-overlay` 
program I was using on the previous version of this.

I'm taking the [run a Procfile with the overmind service](https://github.com/DarthSim/overmind)
route here.

#### Tunnel setup

You will need to run the following to configure the tunnel so that it has
a domain name associated with it:

    cloudflared tunnel route dns your-cloudflare-tunnel-ID server.your-host.com

#### Building

Running locally:

You can use the `go` script to run this locally:

    ./go

**NOTE**: The following environmental variables will have to be set in order
for this to work. Substitute actual values for the description:

    export ACCOUNT_TAG="your-cloudflare-account-tag"
    export TUNNEL_SECRET="your-cloudflare-tunnel-secret"
    export TUNNEL_ID="your-cloudflare-tunnel-ID"
    export TUNNEL_NAME="your-cloudflare-tunnel-name"

For `fly.io`, you'll have to use the:

    flyctl secrets set ACCOUNT_TAG="..." TUNNEL_SECRET="..." TUNNEL_ID="..." TUNNEL_NAME="..."

command to set the secrets, so they'll be available when your app runs.
