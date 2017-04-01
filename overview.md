# MXNetonYARN Basic Design

## Basic Design

Here is the basic design of MXNetOnYARN:

![Basic Design](https://cloud.githubusercontent.com/assets/3848789/24576471/f6c39260-16ee-11e7-994c-c81b9e588078.png)
We can see that after users submitted MXNet jobs on client node, MXNetOnYARN will do the following steps:

1. Launching a scheduler in client node. 
2. Client node submit MXNetAPPMaster container.
3. MXNetAPPMaster sends request to `Resource Manager (RM)` for more containers
4. RM contacts with Node Managers, and send allocated containers to MXNetAPPMaster
5. MXNetAPPMaster contacts with Node managers, and launches allocated containers.
6. Containers launches MXNet workers and servers, which registers to Scheduler after being launched.

There is a tricky point here. Let's suppose the number of workers is n and the number of servers is `m`. The number of containers available in the cluster should be no less than `m+n+1` because the ApplicationMaster also need one container to run.  


### Fault Tolerance
In current ApplicationMaster, whole application will be killed if some of containers fails. You can add the fault tolerance feature by adding a blacklist in ApplicationMaster. Each time one container fails, the node should be added to the blacklist and never be used for execution.

### Log Export
All running logs will be export to HDFS. Users can download and check the detailed logs generated during training or inference.

## Setup on YARN
MXNet requires a bundle of third-part packages and dependencies, which are not normally installed in industrial environment. To address this issue, we introduce three solutions:

1. **Docker Solution (Easy to Deploy and Support)** with all dependencies pre-built in images.
2. **Native Solution (Highest Performance)** with all workers and servers running in native or JVM enviroment.
3. **Labeled Solution (Test or Experimental Deployment)** with all dependencies installed on some cluster nodes

Note that Docker Solution needs minimum changes if docker ecosystem is already setup on YARN, but it needs extra resources for docker containers. On the other hand, Native Solution promise highest efficiency with a few modifications, but it relies on other native APIs, e.g., MXNet CPP or Scala APIs, which are not full accomplished. Last but not least, Labeled Solution requires minimum changes on current environment, which is suggested for test or experimental deployment, but its capability is limited by the number of labeled nodes.

### Docker Support

### Native Support (without Python)
**Note that this part is under modification, some details may be not final.** 

### Labeled Python nodes

### Serving (Inference)

## Discussion

## References





