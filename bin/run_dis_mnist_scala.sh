#!/bin/bash
# Kvstore log for Debug
#export PS_VERBOSE=1
#ps-lite/tracker/dmlc_local.py -n 2 -s 2 \

PLATFORM = linux-x86_64-cpu
LAUNCH_SCRIPT = ../mxnet/tools/launch.py
MODEL = yarn

$LAUNCH_SCRIPT -n 2 --launcher $MODEL \
  java -Xmx4G -Djava.library.path=scala-package/native/$PLATFORM/target/ \
  -cp scala-package/assembly/$PLATFORM/target/*:scala-package/examples/target/*:scala-package/examples/target/classes/lib/* \
  ml.dmlc.mxnet.examples.imclassification.GenTrain \
  --data-dir=data/ \
  --num-epochs=4 \
  --network=mlp \
  --kv-store=dist_async \
#  --kv-store=dist_sync \
#  --num-worker=2 \
#  --num-server=2 \
