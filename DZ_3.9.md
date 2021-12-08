## ДЗ 3.9. Элементы безопасности информационных систем Ворсин Денис

### 1. Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.

Установлен.

![screenshot](DZ_3.9/)

Пароль сохранён.

![screenshot](DZ_3.9/)

### 2. Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.

Двухфакторная авторизация настроена.


![screenshot](DZ_3.9/)


### 3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.


Апач установлен и сертификат сгенерирован. В качестве тестового сайта использована тестовая страница.
```shell
apt install apache2
a2enmod ssl
a2ensite default-ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
```

![screenshot](DZ_3.9/)

### 4. Проверьте на TLS уязвимости произвольный сайт в интернете.

![screenshot](DZ_3.9/)

### 5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.


```shell
apt install ssh-tools
#генерация ключа:
ssh-keygen -t rsa
#copy public
ssh-copy-id vagrant@192.168.33.10
#добавили имя хоста в файл, /etc/hosts. по умолчанию ssh подключается с именем текущего  пользователя
ssh sshtest_vagrant
```

![screenshot](DZ_3.9/)

![screenshot](DZ_3.9/)

![screenshot](DZ_3.9/)

![screenshot](DZ_3.9/)

### 6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.

Переименовали файл ключа и прописали другое имя хосту в файле `~/.ssh/config`

![screenshot](DZ_3.9/)

### 7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.

собрали дамп

![screenshot](DZ_3.9/)

Посмотрели его в `wireshark`

![screenshot](DZ_3.9/)