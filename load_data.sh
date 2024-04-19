#hdfs command to copy patient.txt file present in the local file system to hdfs

hadoop fs -copyFromLocal /root/Desktop/PDTV/Dataset/patient.txt /user/PDTV
hadoop fs -ls /user/PDTV