#!/usr/bin/env python3

import socket
import datetime
import time
import json
import yaml

hosts = {"drive.google.com":"0.0.0.0", "mail.google.com":"0.0.0.0", "google.com":"0.0.0.0"}
print("до проверки имён хостов")
for name in hosts:
    print(name,"-",hosts[name])
# now we run endless:
#
while 1==1 :
    print("Дата проверки:", str(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")))
    for name in hosts:
        host_ip = socket.gethostbyname(name)
        if hosts[name] != host_ip:
            print("[ERROR] ", name,"IP mismatch:",hosts[name],host_ip)
            hosts[name] = host_ip
            fj = open('hosts.json', 'w')
            json.dump(hosts,fj)
            fj.close()
            fy = open('hosts.yaml', 'w')
            yaml.dump(hosts, fy)
            fy.close()

    print("Текущие адреса сервисов.")
    for name in hosts:
        print(name,"-",hosts[name])
    time.sleep(5)

