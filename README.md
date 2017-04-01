# MXNetOnYARN
MXNet on YARN is a project based on [dmlc-core](https://github.com/dmlc/dmlc-core) and [MXNet](https://github.com/dmlc/mxnet), aiming at running MXNet on YARN with high efficiency and flexibility. It's an important part of Deep Learning on Hadoop ([HDL](https://github.com/Intel-bigdata/HDL)). 

**Note that both the codebase and documentation are work in progress. They may not be the final version.**

## Overview

Performing large scale training or predicting tasks with high efficiency is always a big challenge in machine learning and deep learning. Because in most cases, training datasets, computation graphs or variables etc, are always too large for single node. To address this issue, distributed support (or enabling) on current cluster environments, i.e., Hadoop YARN, is very import for current deep learning frameworks. 

In this project, we proposed **MXNetOnYARN** to enable MXNet distributed training and serving on Hadoop YARN, which has been used successfully to run all sorts of distributed data applications. 

![Basic Design](images/mx_yarn.png)

With the help of MXNetOnYARN, users can submit multiple MXNet training or serving tasks to existing YARN cluster **without any modifications on jobs or any worry about building environment or dependencies**, etc. MXNetOnYARN will handle all details about distributed machine learning with high efficiency and flexibility. When the tasks are finished, all resources  will be released, with results and logs be saved to HDFS.

## How-To

This note describes how to deploy and run the training on Yarn.

**The basic command is as follows:**

```bash
ydl-mx [cluster_command] [task_command]
```
Users can use this command to submit training or serving tasks with specific parameters or datasets. Note that 

`cluster_command` is used to specifies the distributed environment, e.g., number of workers and servers launched. Normally, users only needs to specify the number of workers, then MXNetOnYARN will launch the same number of servers. So `--n 2` means launch 2 workers and 2 server, while `--n 2 --s 1` means launch 2 workers and 1 server.

`task_command` is the command that specifies the detailed configure of machine learning tasks, e.g., `job.py --kv-store sync --data-dir` for distributed training. The basic format is similar to single node MXNet tasks without `python` prefix. So, all MXNet parameters are supported, and can be added to `task_command`.

### Pre-Preparation


**1. Distribution support in your MXNet jobs**

In your code, modify demos with [distribution support](http://mxnet.io/how_to/multi_devices.html) (e.g., `train_mnist.py`), or add create a `kvstore` and explicitly set it in your model.

	kv = mx.kvstore.create('dist_sync')
	model = mx.model.FeedForward.create(symbol = net, X = data, kvstore = kv, ...)
	
The use of parameter server is based on the [kvstore class](http://mxnet.io/api/python/kvstore.html) in MXNet.	

**2. Build `ydl-mx.jar`**

Assuming you have successfully [mxnet-scala]() with [distributed support]() (set `USE_HDFS = 1` in `config.mk` when building `libmxnet.so`), you can build `ydl-mx.jar` with following steps:

1. Deploy HDFS and Yarn system. For convenience, we usually set the HDFS namenode and Yarn resourcemanager to be on the same machine.
2. Set environment variables in `/etc/profile`. The variables need to be set are: `JAVA_HOME`, `HADOOP_HOME`, `HADOOP_HDFS_HOME`, `LD_LIBRARY_PATH`. For CDH Hadoop version, you have to download all the hadoop jars and add all these jar files in `CLASSPATH` variable.
3. If you are using CDH Hadoop, download the `libhdfs.so` and copy it to `LD_LIBRARY_PATH` folder.
4. Run `hadoop-yarn-applications-mxnet/build.sh` to compile Yarn ApplicationMaster and Client.


### How to Run

For example, we can submit the application like this:

	/bin/ydl-mx --n 2 --jobname MXNetOnYarn --jar ydl-mx.jar train_minist.py --kv-store sync --data-dir .

**`cluster_command`**:

	`--jobname` specifies the name of job
	`--n` specifies the number of workers and servers
	`--jar` specifies the path for `ydl-mx.jar`.
	

**`task_command`**

	train_minist.py --kv-store sync --data-dir .
	
This command is used to execute the `mnist.py` example with distributed support, i.e., `--kv-store sync`.

### Serving (Inference)

## Discussion

## References





