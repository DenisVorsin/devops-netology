#!/usr/bin/env bash

#список адресов для проверки
Addrs=("10.0.2.15" "173.194.222.113" "87.250.250.242")
#количество попыток для проверки
n=5
#Расположение Лог-файла
LogFile="./some.log"


while ((1==1))
do
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
    if [[ $rez != 0 ]]; then echo "$(date +%Y%m%d_%H:%M) Connection with ${Addrs[$i]} failed " >> $LogFile; exit; fi
    let j+=1
  done
let i+=1
done

sleep 1
done

