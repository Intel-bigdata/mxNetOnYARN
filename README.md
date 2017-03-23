# MXNetOnYARN
MXNet on YARN is a project based on [dmlc-core](https://github.com/dmlc/dmlc-core) and [MXNet](https://github.com/dmlc/mxnet), aiming at running MXNet on YARN with high efficiency and flexibility. It's an important part of Deep Learning on Hadoop ([HDL](https://github.com/Intel-bigdata/HDL)). 

**Note that both the codebase and documentation are work in progress. They may not be the final version.**

## Basic Design
Performing large scale training or predicting tasks with high efficiency is always a big challenge in machine learning. Because in most cases, the training datasets, computation graphs or variables etc, are too large for single node. To address this issue, distributed support on current environment . 

In this project, we proposed **MXNetOnYARN** which enables MXNet distributed training and serving on existing YARN environment with high efficiency and flexibility. 

![Basic Design](images/mx_yarn.png)

With the help of MXNetOnYARN, users can submit multiple MXNet training or serving tasks to existing YARN cluster without any worry about building environment or dependencies etc.

The basic command is as follows:

```bash
ydl-mx 
```


![Basic Design](images/mx_yarn_workflow.png)

After users submitted MXNet jobs on client node, MXNetOnYARN will do the following steps:

1. Launches a scheduler on client node for synchronization. 
2. Client node submit MXNetAPPMaster container.
3. MXNetAPPMaster sends request to `Resource Manager (RM)` for more containers
4. RM contacts with Node Managers, and send allocated containers to MXNetAPPMaster
5. MXNetAPPMaster contacts with Node managers, and launches allocated containers.
6. Containers launches MXNet workers and servers, which registers to Scheduler after being launched.

## MXNetonYARN Detailed Design

### Training

#### Docker Support

#### Native Support (without Python)

### Serving (Inference)

## Discussion

## References




