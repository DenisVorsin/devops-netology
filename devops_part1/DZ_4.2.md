# ДЗ "4.2. Использование Python для решения типовых DevOps задач" Ворсин Денис

## Обязательная задача 1

Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

### Вопросы:
| Вопрос  | Ответ                                                                       |
| ------------- |-----------------------------------------------------------------------------|
| Какое значение будет присвоено переменной `c`?  | будет ошибка: TypeError: unsupported operand type(s) for +: 'int' and 'str' |
| Как получить для переменной `c` значение 12?  | оба значения должны быть типа str ( например: c = str(a) + str(b) )         |
| Как получить для переменной `c` значение 3?  | оба значения должны быть типа int ( например: с = int(a) + int(b) )         |

## Обязательная задача 2
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```
  

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
os.chdir("/home/denisvorsin/devops-netology")
bash_command = ["cd ~/devops-netology", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
cur_dir=os.getcwd()
is_change = False
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено:   ', '')
        print(cur_dir.strip() + "/" + prepare_result.strip())
        # break
```

### Вывод скрипта при запуске при тестировании:
```
denisvorsin@denisvorsin-VirtualBox:~/devops-netology/DZ_4.2$ ./task_example_4.2.2.py 
/home/denisvorsin/devops-netology/DZ_4.2.md
/home/denisvorsin/devops-netology/DZ_4.2/task1.py
/home/denisvorsin/devops-netology/DZ_4.2/task_example_4.2.2.py
```

## Обязательная задача 3
1. Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys

try:
    sys.argv[1]
except:
    print("Директория не указана. Используем значение по умолчанию.")
    work_dir = "/home/denisvorsin/devops-netology"
else:
    work_dir = sys.argv[1]

os.chdir(work_dir)
bash_command = ["cd " +work_dir, "git status"]

# Проверяем, является ли каталог репозиторем git
res=os.system("git status > /dev/null 2>&1")
if  res > 0 :
    print("Указанный каталог не является репозиторием git")
    sys.exit()

result_os = os.popen(' && '.join(bash_command)).read()
cur_dir=os.getcwd()
is_change = False
for result in result_os.split('\n'):
    if result.find('изменено') != -1:
        prepare_result = result.replace('\tизменено:   ', '')
        print(cur_dir.strip() + "/" + prepare_result.strip())
        # break
```

### Вывод скрипта при запуске при тестировании:
```
denisvorsin@denisvorsin-VirtualBox:~/devops-netology/DZ_4.2$ ./task_4.2.3.py
Директория не указана. Используем значение по умолчанию.
/home/denisvorsin/devops-netology/DZ_4.2.md
/home/denisvorsin/devops-netology/DZ_4.2/task1.py
/home/denisvorsin/devops-netology/DZ_4.2/task_4.2.3.py
/home/denisvorsin/devops-netology/DZ_4.2/task_example_4.2.2.py
denisvorsin@denisvorsin-VirtualBox:~/devops-netology/DZ_4.2$ ./task_4.2.3.py /home/denisvorsin/
Указанный каталог не является репозиторием git
denisvorsin@denisvorsin-VirtualBox:~/devops-netology/DZ_4.2$ ./task_4.2.3.py /home/denisvorsin/devops-netology
/home/denisvorsin/devops-netology/DZ_4.2.md
/home/denisvorsin/devops-netology/DZ_4.2/task1.py
/home/denisvorsin/devops-netology/DZ_4.2/task_4.2.3.py
/home/denisvorsin/devops-netology/DZ_4.2/task_example_4.2.2.py
denisvorsin@denisvorsin-VirtualBox:~/devops-netology/DZ_4.2$ 

```

## Обязательная задача 4
1. Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: `drive.google.com`, `mail.google.com`, `google.com`.

### Ваш скрипт:
```python
#!/usr/bin/env python3

import socket
import datetime
import time

hosts = {"drive.google.com":"0.0.0.0", "mail.google.com":"0.0.0.0", "google.com":"0.0.0.0"}
print("до проверки имён хостов")
for name in hosts:
    print(name,"-",hosts[name])
# now we run endless:
while 1==1 :
    print("Дата проверки:", str(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")))
    for name in hosts:
        host_ip = socket.gethostbyname(name)
        if hosts[name] != host_ip:
            print("[ERROR] ", name,"IP mismatch:",hosts[name],host_ip)
            hosts[name] = host_ip
    print("Текущие адреса сервисов.")
    for name in hosts:
        print(name,"-",hosts[name])
    time.sleep(5)

```

### Вывод скрипта при запуске при тестировании:
```
denisvorsin@denisvorsin-VirtualBox:~/devops-netology/DZ_4.2$ ./task_4.2.4.py
до проверки имён хостов
drive.google.com - 0.0.0.0
mail.google.com - 0.0.0.0
google.com - 0.0.0.0
Дата проверки: 2021-12-20 12:53:21
[ERROR]  drive.google.com IP mismatch: 0.0.0.0 64.233.164.194
[ERROR]  mail.google.com IP mismatch: 0.0.0.0 64.233.161.19
[ERROR]  google.com IP mismatch: 0.0.0.0 173.194.221.113
Текущие адреса сервисов.
drive.google.com - 64.233.164.194
mail.google.com - 64.233.161.19
google.com - 173.194.221.113
Дата проверки: 2021-12-20 12:53:26
[ERROR]  google.com IP mismatch: 173.194.221.113 173.194.221.102
Текущие адреса сервисов.
drive.google.com - 64.233.164.194
mail.google.com - 64.233.161.19
google.com - 173.194.221.102
Дата проверки: 2021-12-20 12:53:31
Текущие адреса сервисов.
drive.google.com - 64.233.164.194
mail.google.com - 64.233.161.19
google.com - 173.194.221.102
Дата проверки: 2021-12-20 12:53:36
Текущие адреса сервисов.
drive.google.com - 64.233.164.194
mail.google.com - 64.233.161.19
google.com - 173.194.221.102
Дата проверки: 2021-12-20 12:53:41
Текущие адреса сервисов.
drive.google.com - 64.233.164.194
mail.google.com - 64.233.161.19
google.com - 173.194.221.102

```

