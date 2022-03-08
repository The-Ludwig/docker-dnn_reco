#!/bin/bash

docker cp test_data/ $1:/root/test_data
docker exec $1 mkdir /root/configs
docker cp test.yaml $1:/root/configs/test.yaml
