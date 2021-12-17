#!/usr/bin/env bash

#список адресов для проверки
Addrs=("192.168.0.1" "173.194.222.113" "87.250.250.242")
#количество попыток для проверки
n=5
#Расположение Лог-файла
LogFile="./some.log"

i=0
while (( $i < ${#Addrs[@]} ))
do
echo "$(date +%Y%m%d_%H:%M) Test ${Addrs[$i]}" >> $LogFile
j=0
  while (( $j < $n ))
  do
    curl -s http://${Addrs[$i]}:80 > /dev/null
    rez=$?
    echo "$(date +%Y%m%d_%H:%M) try$(($j+1)): $( if [[ $rez == 0 ]]; then echo success; else echo failed; fi )" >> $LogFile
    let j+=1
  done
let i+=1
done


