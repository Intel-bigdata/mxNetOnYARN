#!/bin/bash
#export PS_VERBOSE=1
#ps-lite/tracker/dmlc_local.py -n 2 -s 2 \
../mxnet/tools/launch.py -n 2 --launcher local --native scala python train_mnist.py --kv-store dist_sync $@
#  --kv-store=dist_sync \
#  --num-worker=2 \
#  --num-server=2 \
#  --scheduler-host=10.239.12.123 \
#  --scheduler-port=9099
