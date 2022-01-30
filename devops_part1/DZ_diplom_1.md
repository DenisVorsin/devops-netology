## Курсовая работа по итогам модуля "DevOps и системное администрирование" Ворсин Денис.


### 1. Процесс установки и настройки ufw


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

### 2. Процесс установки и выпуска сертификата с помощью hashicorp vault

Установка:

![vault1](DZ_diplom_1/2021-12-15%2018_05_34_vault1.jpg)

![vault2](DZ_diplom_1/2021-12-15%2018_05_16_vault2.jpg)

Выпуск сертификата:
```shell
vault write -field=certificate pki/root/generate/internal common_name="denisvorsin.local" ttl=87600h > CA_cert.crt
vault write pki/config/urls issuing_certificates="$VAULT_ADDR/v1/pki/ca" crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
vault secrets enable -path=pki_int pki
vault write -format=json pki_int/intermediate/generate/internal common_name="example.com Intermediate Authority" | jq -r '.data.csr' > pki_intermediate.csr
vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr format=pem_bundle ttl="43800h" | jq -r '.data.certificate' > intermediate.cert.pem
vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem

#добавление роли
vault write pki_int/roles/denisvorsin-dot-local allowed_domains="denisvorsin.local" allow_subdomains=true max_ttl="720h"

#certificate request
vault write pki_int/issue/denisvorsin-dot-local common_name="test.denisvorsin.local" ttl="720h"

```

Скриншот с выпуска сертификата:

![gen1](DZ_diplom_1/2021-12-16%2022_40_00.jpg)

![gen2](DZ_diplom_1/2021-12-16%2022_40_36.jpg)

### 3. Процесс установки и настройки сервера nginx

```shell
sudo apt install nginx
sudo systemctl enable nginx
vi /etc/nginx/sites-available/default
sudo systemctl start nginx
```
![nginx](DZ_diplom_1/2021-12-15%2018_06_57_nginx1.jpg)

Конфигурация nginx:

![nginx](DZ_diplom_1/2021-12-16%2018_16_11.jpg)

### 4. Страница сервера nginx в браузере хоста не содержит предупреждений

![chrome](DZ_diplom_1/2021-12-16%2018_05_23.jpg)

![chrome](DZ_diplom_1/2021-12-16%2018_06_07.jpg)

![cert](DZ_diplom_1/2021-12-16%2018_02_35.jpg)

### 5. Скрипт генерации нового сертификата работает (сертификат сервера ngnix должен быть "зеленым")

Для обновления сертификата использовано приложение consul-template
Ниже его настройки:

![consul](DZ_diplom_1/2021-12-16%2018_00_24.jpg)

### 6. Crontab работает (выберите число и время так, чтобы показать что crontab запускается и делает что надо)

Для демонстрации в кроне в качестве времени для запуска использовал текущее время. 
Далее через `journalctl` вывел текущие логи системы где видно момент запуска `cron` 

![cron1](DZ_diplom_1/2021-12-16%2017_59_44.jpg)

![cron2](DZ_diplom_1/2021-12-16%2017_56_52.jpg)