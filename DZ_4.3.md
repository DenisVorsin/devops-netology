# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML" Ворсин Денис


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

  ниже исправленный вариант json (адрес первого сервера - число, какой должен быть адрес - неизвестно):

```json
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : "7175" 
            },
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```

![картинка]()

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
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
            fj = open('hosts.json','w')
            json.dump(hosts,fj)
            fj.close()
            fy = open('hosts.yaml','w')
            yaml.dump(hosts, fy)
            fy.close()

    print("Текущие адреса сервисов.")
    for name in hosts:
        print(name,"-",hosts[name])
    time.sleep(5)
```

### Вывод скрипта при запуске при тестировании:
```
denisvorsin@denisvorsin-VirtualBox:~/devops-netology/DZ_4.3$ ./task_4.3.2.py 
до проверки имён хостов
drive.google.com - 0.0.0.0
mail.google.com - 0.0.0.0
google.com - 0.0.0.0
Дата проверки: 2021-12-20 14:10:32
[ERROR]  drive.google.com IP mismatch: 0.0.0.0 173.194.222.194
[ERROR]  mail.google.com IP mismatch: 0.0.0.0 64.233.161.18
[ERROR]  google.com IP mismatch: 0.0.0.0 74.125.131.101
Текущие адреса сервисов.
drive.google.com - 173.194.222.194
mail.google.com - 64.233.161.18
google.com - 74.125.131.101
Дата проверки: 2021-12-20 14:10:37
[ERROR]  mail.google.com IP mismatch: 64.233.161.18 64.233.161.19
[ERROR]  google.com IP mismatch: 74.125.131.101 74.125.131.102
Текущие адреса сервисов.
drive.google.com - 173.194.222.194
mail.google.com - 64.233.161.19
google.com - 74.125.131.102
Дата проверки: 2021-12-20 14:10:42
Текущие адреса сервисов.
drive.google.com - 173.194.222.194
mail.google.com - 64.233.161.19
google.com - 74.125.131.102
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{"drive.google.com": "173.194.222.194", "mail.google.com": "64.233.161.19", "google.com": "74.125.131.102"}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
drive.google.com: 173.194.222.194
google.com: 74.125.131.102
mail.google.com: 64.233.161.19
```
скриншот:

![term](DZ_4.3/2021-12-20%2014_11_07.jpg)

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
???
```

### Пример работы скрипта:
???
