**2. Build `ydl-mx.jar`**

Assuming you have deployed HDFS and Yarn system, and have successfully built [mxnet-scala](http://mxnet.io/get_started/build_from_source.html#build-the-scala-package) with [distributed support](http://mxnet.io/how_to/multi_devices.html) (set `USE_HDFS = 1` in `config.mk` when building `libmxnet.so`). Then you can build `ydl-mx.jar` with following steps:


1. Copy all `mxnet-scala` jars ( i.e., `mxnet-examples_XX.jar` in `mxnet/scala-package/examples/target`, `mxnet-full_XX-{your platform}-XX.jar` in `mxnet/scala-package/assembly/{your platform}/target`) to current directory. Note that `{your platform}` means that this jar is platform related.
2. Set environment variables in `/etc/profile`. The variables need to be set are: `JAVA_HOME`, `HADOOP_HOME`, `HADOOP_HDFS_HOME`, `LD_LIBRARY_PATH`. For CDH Hadoop version, you have to download all the hadoop jars and add all these jar files in `CLASSPATH` variable.
3. If you are using CDH Hadoop, download the `libhdfs.so` and copy it to `LD_LIBRARY_PATH` folder.
4. Run `hadoop-yarn-applications-mxnet/build.sh` to compile Yarn ApplicationMaster and Client.
