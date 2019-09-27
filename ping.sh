#!/bin/sh

iparr=(`cat file`)
for ip in ${iparr[@]}
do
    res=`ping -c 1000 -f $ip`
    loss=`echo $res | sed -n 's#.*received, \([0-9]*%\).*#\1#gp'`
    time=`echo $res | sed -n 's#.*min/avg/max/mdev = \([0-9]*.[0-9]*\)/\([0-9]*.[0-9]*\)/\([0-9]*.[0-9]*\)/.*#\1\t\3\t\2#gp'`
    echo $ip $time $loss
done



echo user{1..20}|xargs -n1|sed -r 's#(.*)#useradd \1 \&\& echo \1 >>/tmp/passwd.txt \&\& echo $RANDOM |md5sum |cut -c 1-5>>/tmp/passwd.txt \&\& echo `tail -1 /tmp/passwd.txt`|passwd --stdin \1#g'|bash
echo user{1..20}|xargs -n1|sed -r 's#(.*)#useradd \1 \&\& pass=`echo $RANDOM |md5sum |cut -c 1-5` \&\& echo $pass |passwd --stdin \1 \&\& echo \1 $pass>>/tmp/user_passwd.txt#g'|bash
echo user{1..20}|xargs -n1|sed -r 's#(.*)#useradd \1 \&\& pass=`echo $RANDOM |md5sum |cut -c 1-5` \&\& echo \1:$pass>>/tmp/user_passwd.txt \&\& chpasswd</tmp/user_passwd.txt#g'|bash


#!/bin/bash
n=1
while read i
  do
   echo "第$n行 $i"
   m=1
   for x in $i
     do
       echo "第$m个单词 $x"
       echo $x|grep -o . 
       ((m++))
   done
   ((n++))
done < $1