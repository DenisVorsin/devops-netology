# Д.З. 5.2. Применение принципов IaaC в работе с виртуальными машинами

## Задача 1
Опишите своими словами основные преимущества применения на практике IaaC паттернов.
Какой из принципов IaaC является основополагающим?

Ответ:
```
Главное преимущество от применения IaaC - идемпотентность, тоесть все развёрнутые среды разработки и тестирования будут идентичны.
Основной принцип - процесс создания и настройки инфраструктуры происходит аналогично программированию, тоесть через конфигурационные файлы средств автоматизации. 
```

## Задача 2
Чем Ansible выгодно отличается от других систем управление конфигурациями?
Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?

Ответ:
```
Ansible для подключения к хостам использует имеющуюся инфраструктуру ssh, что упрощает процесс подключения. 
Лично на мой взгляд метод push выглядит более надёжным, т.к. инициатива на моей стороне, 
могу запустить процессы настройки последовательно или параллельно.

```

## Задача 3
Установить на личный компьютер:
- VirtualBox
- Vagrant
- Ansible
Приложить вывод команд установленных версий каждой из программ, оформленный в markdown.

```
$ virtualboxvm --help
Oracle VM VirtualBox VM Runner v6.1.26_Ubuntu
(C) 2005-2021 Oracle Corporation
All rights reserved.

$ vagrant --version
Vagrant 2.2.19

$ ansible --version
ansible 2.9.6
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/sonic/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.8.10 (default, Nov 26 2021, 20:14:08) [GCC 9.3.0]

```

## Задача 4 (*)
Воспроизвести практическую часть лекции самостоятельно.

Создать виртуальную машину.
Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды
docker ps

```
$ vagrant ssh
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat 12 Feb 2022 01:15:41 PM UTC

  System load:  0.56               Users logged in:          0
  Usage of /:   13.4% of 30.88GB   IPv4 address for docker0: 172.17.0.1
  Memory usage: 24%                IPv4 address for eth0:    10.0.2.15
  Swap usage:   0%                 IPv4 address for eth1:    192.168.192.11
  Processes:    115


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Sat Feb 12 13:14:12 2022 from 10.0.2.2
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$ 
```
[Vagrant up log](devops_part2/DZ_5.2/vagrant_up.log)