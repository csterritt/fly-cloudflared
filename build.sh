#!/bin/bash
docker build . -t tunnel-test --build-arg ACCOUNT_TAG --build-arg TUNNEL_SECRET --build-arg TUNNEL_ID --build-arg TUNNEL_NAME
