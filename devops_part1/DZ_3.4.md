## ДЗ 3.4 Операционные системы, Лекция 2. Ворсин Денис 

### 1. На лекции мы познакомились с node_exporter. В демонстрации его исполняемый файл запускался в background. Этого достаточно для демо, но не для настоящей production-системы, где процессы должны находиться под внешним управлением. Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporter:
 - поместите его в автозагрузку,
 - предусмотрите возможность добавления опций к запускаемому процессу через внешний файл (посмотрите, например, на systemctl cat cron),
 - удостоверьтесь, что с помощью systemctl процесс корректно стартует, завершается, а после перезагрузки автоматически поднимается.


Собираем node_exporter (если `apt install prometheus-node-exporter` не наш метод): 
```shell
# обновляем если требуется
sudo apt update
# устанавливаем пакеты для сборки
sudo apt install make
sudo snap install go --classic
sudo apt install gcc
# берём исходник и собираем.
git clone https://github.com/prometheus/node_exporter.git
cd node_exporter/
make
```

добавляем в автозагрузку:

![unit file](https://i.ibb.co/fMxjDVH/2021-11-26-13-04-44.jpg)


проверяем его запуск:

![systemctl](https://i.ibb.co/q936kK5/2021-11-26-13-04-24.jpg)


Проверяем, появился ли сетевой интерфейс:

![network status](https://i.ibb.co/KqCGVb9/2021-11-26-13-05-52.jpg)


Добавляем форвард порта до хостовой машины и делаем `vagrant reload` :

![reload status](https://i.ibb.co/j4JkthN/2021-11-26-13-05-25.jpg)


На хостовой машине проверяет доступность метрик:

![test metrics](https://i.ibb.co/Qc72nCL/2021-11-26-13-03-32.jpg)



### 2. Ознакомьтесь с опциями node_exporter и выводом /metrics по-умолчанию. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.

Метрики для CPU:

![CPU](https://i.ibb.co/SNWwrVw/2021-11-26-13-11-09.jpg)

Метрики для Памяти:

![MEM](https://i.ibb.co/zF0KTrL/2021-11-26-13-11-24.jpg)

Метрики для Дисковой подсистемы:

![DISK](https://i.ibb.co/zrPv6mP/2021-11-26-13-13-21.jpg)

Метрики для Сетевого интерфейса:

![NET](https://i.ibb.co/rfznMKQ/2021-11-26-13-44-09.jpg)


### 3. Установите в свою виртуальную машину Netdata. 


        Пакет netdata установлен, в конфиг файл netdata.conf поменяли настройки сети, в vagrant файле добавлен форвард порта 19999 после чего интерфейс netdata стал доступен с хостовой машины:

![netdata](https://i.ibb.co/0yT0gZx/2021-11-26-13-49-07.jpg)
  

### 4. Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?


        Systemd написал что обнаружена виртуализация.

![systemd virt](https://i.ibb.co/K6TRW35/2021-11-26-14-07-03.jpg)


### 5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр. Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?

 - По умолчанию fs.nr_open имеет значение 1048576. Этот параметр ограничивает количество открытых файловых дескрипторов. 
 - по умолчанию для пользователя разрешено 1024 файловых дескриптора (`ulimit -n`)
 - Приложение, запущенное с правами непривилигированного пользователя может менять свой софт лимит в пределах хард-лимита ([man setrlimit](https://i.ibb.co/86KHcNy/2021-11-26-14-34-06.jpg)). 


![ulimits_1](https://i.ibb.co/pKqJckB/2021-11-26-14-18-31-1.jpg)


### 6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; 
покажите, что ваш процесс работает под PID 1 через nsenter. Для простоты работайте в данном задании под root (sudo -i). Под обычным пользователем требуются дополнительные опции (--map-root-user) и т.д.
 
![unshared](https://i.ibb.co/HXZKxQF/2021-11-26-15-26-20.jpg)


### 7. Найдите информацию о том, что такое `:(){ :|:& };:`. 


        Оно называется "fork-бомба", сначала обьявляется функция :() внутри которой функция вызывает сама себя: :|:& и порождает множество параллельных процессов.
        
 
 Запустите эту команду в своей виртуальной машине Vagrant с Ubuntu 20.04 (это важно, поведение в других ОС не проверялось). Некоторое время все будет "плохо", после чего (минуты) – ОС должна стабилизироваться. 
 Вызов dmesg расскажет, какой механизм помог автоматической стабилизации. 
 Как настроен этот механизм по-умолчанию, и как изменить число процессов, которое можно создать в сессии?

        судя по dmesg выполнение скрипта было прервано механизмом cgroup

![dmesg](https://i.ibb.co/R01cSDJ/2021-11-26-15-42-25.jpg)

механизм описан в `man cgroups`

![man cgroup](https://i.ibb.co/s5FLfdw/2021-11-26-15-44-21.jpg)

проследить какой процесс заспамил, можно через `systemd-cgtop`

![cgtop2](https://i.ibb.co/xLnTh45/2021-11-26-15-58-56.jpg)

изменить ограничение можно через `ulimit -u`

![cgtop1](https://i.ibb.co/yq2GsP3/2021-11-26-16-05-44.jpg)