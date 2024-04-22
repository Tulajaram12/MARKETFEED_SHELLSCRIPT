#!/bin/bash

#LOGFILE PATH IF THE FILE CALLED file.log is presnt in /var/log directory
 path=/var/log/file.log

#SETTING UP THE ENVIRONMENT VARIABLE FOR OLD FILE SIZE
old_size=`du -s /var/log/file.log | awk {'print $1'}`
echo export old_size=$old_size >> /root/.bashrc
source /root/.bashrc

#PRINTING THE OLD SIZE
echo `printenv old_size`

#FINDING OUT THE CURRENT SIZE 
new_size=`du -s /var/log/file.log | awk {'print $1'}`

#PRINTING THE CURRENT SIZE
echo $new_size

echo "whether you want to see the log file details or you want to check the number of ERROR lines in log file"
echo
echo 1. Whether You want to see the Real Time Logs
echo 2. Whether You want to see the Count number of ERROR Lines in logs
read c
echo
if [ $c == 1 ]
then
  if [ $new_size == $old_size ]
  then
  tail -f $path | while read a
   do 
   echo $a
   done
     else
   exit 0 
  fi
else
#COUNTING THE NUMBER OF ERROR LINES
b=`cat  $path | grep ERROR | wc -l`
echo "THE NUMBER OF ERROR OR HTTP LINES IN LOG FILE: $b"
echo $b
fi

