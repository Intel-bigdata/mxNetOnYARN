# MXNetOnYARN
MXNet on YARN is a project based on [dmlc-core](https://github.com/dmlc/dmlc-core) and [MXNet](https://github.com/dmlc/mxnet), aiming at running MXNet on YARN with high efficiency and flexibility. It's an important part of Deep Learning on Hadoop ([HDL](https://github.com/Intel-bigdata/HDL)). 

**Note that both the codebase and documentation are work in progress. They may not be the final version.**

## Basic Design

Performing large scale training or predicting tasks with high efficiency is always a big challenge in machine learning and deep learning. Because in most cases, training datasets, computation graphs or variables etc, are always too large for single node. To address this issue, distributed support (or enabling) on current cluster environments, i.e., Hadoop YARN, is very import for current deep learning frameworks. 

In this project, we proposed **MXNetOnYARN** to enable MXNet distributed training and serving on Hadoop YARN, which has been used successfully to run all sorts of distributed data applications. 

![Basic Design](images/mx_yarn.png)

With the help of MXNetOnYARN, users can submit multiple MXNet training or serving tasks to existing YARN cluster **without any modifications on jobs or any worry about building environment or dependencies**, etc. MXNetOnYARN will handle all details about distributed machine learning with high efficiency and flexibility. When the tasks are finished, all resources  will be released, with results and logs be saved to HDFS.

**The basic command is as follows:**

```bash
ydl-mx yarn [cluster_command] [task_command]
```
Users can use this command to submit training or serving tasks with specific parameters or datasets. Note that 

`cluster_command` is used to specifies the distributed environment, e.g., number of workers and servers launched. Normally, users only needs to specify the number of workers, then MXNetOnYARN will launch the same number of servers. So `-n 2` means launch 2 workers and 2 server, while `-n 2 -s 1` means launch 2 workers and 1 server.

`task_command` is the command that specifies the detailed configure of machine learning tasks, e.g., `job.py --kv-store sync --data-dir` for distributed training. The basic format is similar to single node MXNet tasks without `python` prefix. So, all MXNet parameters are supported, and can be added to `task_command`.

## MXNetonYARN Detailed Design

### Training

![Basic Design](images/mx_yarn_workflow.png)
After users submitted MXNet jobs on client node, MXNetOnYARN will do the following steps:

1. Launch a scheduler on client node. 
2. Client node submit MXNetAPPMaster container.
3. MXNetAPPMaster sends request to `Resource Manager (RM)` for more containers
4. RM contacts with Node Managers, and send allocated containers to MXNetAPPMaster
5. MXNetAPPMaster contacts with Node managers, and launches allocated containers.
6. Containers launches MXNet workers and servers, which registers to Scheduler after being launched.


#### Docker Support

#### Native Support (without Python)

### Serving (Inference)

## Discussion

## References





