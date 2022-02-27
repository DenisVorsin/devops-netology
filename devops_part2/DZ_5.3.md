# ДЗ 5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера. Ворсин Денис

## Задача 1

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

Ответ:
```
https://hub.docker.com/repository/docker/denisvorsin/local_nginx

Как создавался образ:
Dockerfile:
FROM nginx
COPY index.html /usr/share/nginx/html/

далее сборка:
docker build -t denisvorsin/local_nginx:01 .
docker push denisvorsin/local_nginx:01
```


## Задача 2

Посмотрите на сценарий ниже и ответьте на вопрос:
"Подходит ли в этом сценарии использование Docker контейнеров или лучше подойдет виртуальная машина, физическая машина? Может быть возможны разные варианты?"

Детально опишите и обоснуйте свой выбор.

--

Сценарий:

1. Высоконагруженное монолитное java веб-приложение;
2. Nodejs веб-приложение;
3. Мобильное приложение c версиями для Android и iOS;
4. Шина данных на базе Apache Kafka;
5. Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
6. Мониторинг-стек на базе Prometheus и Grafana;
7. MongoDB, как основное хранилище данных для java-приложения;
8. Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.

Ответ:

```
В общем случае видел все описанные случаи в виде контейнеров для кубернетис кластера

1. Высоконагруженное монолитное java веб-приложение;
docker контейнер ограничен в ресурсах, поэтому для высоконагруженного приложения больше подойдет виртуальный сервер с полной виртуализацией. 

2. Nodejs веб-приложение;
Приложение достаточно простое, работает как процесс следовательно можно разместить в докере. 

3. Мобильное приложение c версиями для Android и iOS;
в докер-контейнере может быть размещено приложение для той же ОС, на которой работает хост, 
для iOS скорее всего потребуется специальный виртуальный сервер,
но т.к. разработкой под ios не занимался, то сказать трудно.

4. Шина данных на базе Apache Kafka;
Apache Kafka работает на Linux
в репозитарии есть образ для докера:
https://hub.docker.com/r/bitnami/kafka/
следовательно может быть размещено в docker.

5. Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana;
Для ELK есть образы:
https://hub.docker.com/_/elasticsearch
https://www.elastic.co/guide/en/logstash/current/docker.html
https://www.elastic.co/guide/en/kibana/current/docker.html

Есть описание как запустить в докере - следовательно можно запустить в докере.


6. Мониторинг-стек на базе Prometheus и Grafana;
https://prometheus.io/docs/prometheus/latest/installation/
https://grafana.com/docs/grafana/latest/installation/docker/

Есть специальный докер-образы. есть описание - следовательно Grafana и Prometheus могут быть запущено в докере. 

7. MongoDB, как основное хранилище данных для java-приложения;
https://hub.docker.com/_/mongo

Есть официальный докер-образ, есть описание, следовательно может быть запущено в докере. 

8. Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry.
https://docs.gitlab.com/ee/install/docker.html

Есть официальный докер-образ, есть описание - может быть запущено в докер-контейнере. 

```

## Задача 3

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.

Ответ:

```
$ docker build -t local_centos centos_build/.
Sending build context to Docker daemon  4.096kB
Step 1/3 : FROM centos:latest
 ---> 5d0da3dc9764
Step 2/3 : COPY runner.sh /runner.sh
 ---> 63842a7b57c2
Step 3/3 : CMD ["/runner.sh"]
 ---> Running in c4e836cba500
Removing intermediate container c4e836cba500
 ---> 121f5285130a
Successfully built 121f5285130a
Successfully tagged local_centos:latest

$ docker build -t local_debian debian_build/.
Sending build context to Docker daemon  4.096kB
Step 1/3 : FROM debian:latest
 ---> 04fbdaf87a6a
Step 2/3 : COPY runner.sh /runner.sh
 ---> 2b5e4aca46f2
Step 3/3 : CMD ["/runner.sh"]
 ---> Running in 11d5467d0d92
Removing intermediate container 11d5467d0d92
 ---> d963c46d0296
Successfully built d963c46d0296
Successfully tagged local_debian:latest

$ docker run -d --name centos_1 --mount source=$(pwd)/data,target=/data,type=bind local_centos
687da4c54f6c6af84b41be86e3206336380aea36fdbe928beca61c0aaefa8ecf

$ docker run -d --name debian_1 --mount source=$(pwd)/data,target=/data,type=bind local_debian
acea3dc7a29c551fcc21022d55be7cd4585f7f0b4ed60bcc6797e3507dac0982

$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                                   NAMES
acea3dc7a29c   local_debian   "/runner.sh"             30 seconds ago   Up 30 seconds                                           debian_1
687da4c54f6c   local_centos   "/runner.sh"             2 minutes ago    Up 2 minutes                                            centos_1

$ docker exec -ti centos_1 bash
[root@687da4c54f6c /]# echo centos > /data/centos_file

$ echo host > ./data/host_file

$ docker exec -ti debian_1 bash
root@acea3dc7a29c:/# ls /data/
centos_file  host_file
root@acea3dc7a29c:/# cat /data/*
centos
host

```

## Задача 4 (*)

Воспроизвести практическую часть лекции самостоятельно.

Соберите Docker образ с Ansible, загрузите на Docker Hub и пришлите ссылку вместе с остальными ответами к задачам.

Ответ:
```
https://hub.docker.com/repository/docker/denisvorsin/local_ansible

```
