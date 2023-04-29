#!/bin/bash
docker build . -t tunnel-test && \
    docker run --rm --env ACCOUNT_TAG --env TUNNEL_SECRET --env TUNNEL_ID --env TUNNEL_NAME tunnel-test
