#hdfs command to copy patient.txt file present in the local file system to hdfs

hadoop fs -copyFromLocal /root/Desktop/user_repo/To_Participant/AdditionalSuppliedFiles/patient.txt /user/BigDataTesting
hadoop fs -ls /user/BigDataTesting