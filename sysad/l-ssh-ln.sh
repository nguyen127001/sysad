root@uat-eco-mysql1:~ cat /usr/bin/l
#!/bin/bash			
IP=`cat /etc/.serverlist |grep "\.$1$"`			
if [ ! -z $IP ] ; then			
ssh $IP			
else			
echo "$1 $IP not exsit, or need parameter ."			
fi


root@uat-eco-mysql1:~ cat /etc/.serverlist 
10.2.9.70
10.2.9.71
10.2.9.72
10.2.9.73
10.2.9.74
10.2.9.75