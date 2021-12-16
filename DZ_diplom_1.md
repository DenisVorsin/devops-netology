Курсовая работа по итогам модуля "DevOps и системное администрирование" Ворсин Денис.


1. Процесс установки и настройки ufw


        В Ubuntu 20.04 ufw установлен по умолчанию, но выключен.
        Для включения:
```shell
sudo ufw enable
```


        Разрешение доступа для входящих подключения на портах 22 и 443:
```shell
sudo ufw allow ssh
sudo ufw allow in to 10.0.2.15 port 443
sudo ufw allow in to 192.168.33.12 port 443
```


        Разрешение трафика на lo интерфейсах
```shell
sudo ufw allow in on lo
sudo ufw allow out on lo
```


        для включения запрещающих правил "по умолчанию":
```shell
sudo ufw default deny incoming
sudo ufw default deny outgoing
```

2. Процесс установки и выпуска сертификата с помощью hashicorp vault



3. Процесс установки и настройки сервера nginx

```shell
sudo apt install nginx
sudo systemctl enable nginx
vi /etc/nginx/sites-available/default
sudo systemctl start nginx
```


4. Страница сервера nginx в браузере хоста не содержит предупреждений



5. Скрипт генерации нового сертификата работает (сертификат сервера ngnix должен быть "зеленым")


Для обновления сертификата использовано приложение consul-template
Ниже его настройки:


6. Crontab работает (выберите число и время так, чтобы показать что crontab запускается и делает что надо)


