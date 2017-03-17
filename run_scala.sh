#!/bin/bash

java -Xmx4G -Djava.library.path=scala-package/native/linux-x86_64-cpu/target/ \
  -cp scala-package/assembly/linux-x86_64-cpu/target/*:scala-package/examples/target/*:scala-package/examples/target/classes/lib/* \
  ml.dmlc.mxnet.examples.imclassification.TrainMnist $@ \
  --data-dir=data/ \
#  --num-epochs=10 \
#  --network=mlp \
#  --cpus=0,1,2,3
