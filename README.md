# MXNetOnYARN
MXNet on YARN is a project based on [dmlc-core](https://github.com/dmlc/dmlc-core) and [MXNet](https://github.com/dmlc/mxnet), aiming at running MXNet on YARN with high efficiency and flexibility. It's an important part of Deep Learning on Hadoop ([HDL](https://github.com/Intel-bigdata/HDL)).

## Basic Design

### MXNet Jobs on YARN
This note describes how to deploy and run the training on Yarn.
As has been described in http://mxnet.readthedocs.org/en/latest/distributed_training.html. The use of parameter server is based on the kvstore class in MXNet.
In your code, create a kvstore and explicitly set it in your model.

kv = mx.kvstore.create('dist_sync')
model = mx.model.FeedForward.create(symbol = net, X = data, kvstore = kv, ...)

How to Deploy
1.Deploy HDFS and Yarn system. For convenience, we usually set the HDFS namenode and Yarn resourcemanager to be on the same machine.

2.Set environment variables in /etc/profile. The variables need to be set are: JAVA_HOME, HADOOP_HOME, HADOOP_HDFS_HOME, LD_LIBRARY_PATH. For CDH Hadoop version, you have to download all the hadoop jars and add all these jar files in CLASSPATH variable.

3.If you are using CDH Hadoop, download the libhdfs.so and copy it to *LD_LIBRARY_PATH* folder.

4.Set USE_HDFS = 1, USE_DIST_KVSTORE = 1 in MXNet config.mk before compilation.

5.Run hadoop-yarn-applications-mxnet/build.sh to compile Yarn ApplicationMaster and Client.

How to Run
For example, we can submit the application like this:

./bin/ydl-mx --cluster yarn --num-workers 1 --num-servers 1 --jobname MXNetOnYarn --yarn-app-dir yarn/ python minist.py
python mnist.py is the command to execute the mnist.py.

--cluster  specifies the ip address of resourcemanager
----num-workers specifies the number of workers
--num-servers specifies the number of servers
--yarn-app-dir specifies the folder for dmlc-yarn.jar.

There is a tricky point here. Let's suppose the number of workers is n and the number of servers is m. The number of containers available in the cluster should be no less than m+n+1 because the ApplicationMaster also need one container to run.  

Fault Tolerance
In current ApplicationMaster, whole application will be killed if some of containers fails. You can add the fault tolerance feature by adding a blacklist in ApplicationMaster. Each time one container fails, the node should be added to the blacklist and never be used for execution.

### Basic Workflow

### Advantages

## Discussion


## References

Both the codebase and documentation are work in progress.




