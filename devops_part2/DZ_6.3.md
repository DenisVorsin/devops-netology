# ДЗ 6.3. MySQL. Ворсин Денис.

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

В следующих заданиях мы будем продолжать работу с данным контейнером.

Ответ:

Docker-compose файл для создания инстанса [docker-compose.yaml](DZ_6.3/src/docker-compose.yaml)
```
sonic@sonic-X550JK:~/devops-netology/devops_part2/DZ_6.3/src$ docker exec -ti mysql_1 bash
root@4a0518efea99:/# mysql -u test -ptest-pass test_db < /opt/scripts/test_data/test_dump.sql
mysql: [Warning] Using a password on the command line interface can be insecure.
root@4a0518efea99:/opt/scripts/test_data# mysql -u test -ptest-pass test_db                                       
mysql: [Warning] Using a password on the command line interface can be insecure.
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 12
Server version: 8.0.28 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| test_db            |
+--------------------+
2 rows in set (0.00 sec)

mysql> \s
--------------
mysql  Ver 8.0.28 for Linux on x86_64 (MySQL Community Server - GPL)

mysql> use test_db;
Database changed
mysql> show tables;
+-------------------+
| Tables_in_test_db |
+-------------------+
| orders            |
+-------------------+
1 row in set (0.00 sec)

mysql> select count(*) from orders where price > '300';
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)

```

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
    
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.

Ответ:

Плагин авторизации указан в docker-compose.yaml, пользователь test там же создан. 
Вручную создадим пользователя test_1: [create_user.sql](DZ_6.3/src/create_user.sql)
```
sonic@sonic-X550JK:~/devops-netology/devops_part2/DZ_6.3/src$ docker exec -ti mysql_1 bash
root@4a0518efea99:/# mysql -ptest-pass test_db < /opt/scripts/create_user.sql 
mysql: [Warning] Using a password on the command line interface can be insecure.
root@4a0518efea99:/# mysql -ptest-pass test_db                                
mysql: [Warning] Using a password on the command line interface can be insecure.
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 15
Server version: 8.0.28 MySQL Community Server - GPL

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER='test_1';
+--------+-----------+---------------------------------------+
| USER   | HOST      | ATTRIBUTE                             |
+--------+-----------+---------------------------------------+
| test_1 | localhost | {"fname": "James", "lname": "Pretty"} |
+--------+-----------+---------------------------------------+
1 row in set (0.00 sec)

mysql> show grants for 'test_1'@'localhost';
+------------------------------------------------------------+
| Grants for test_1@localhost                                |
+------------------------------------------------------------+
| GRANT USAGE ON *.* TO `test_1`@`localhost`                 |
| GRANT SELECT ON `test_db`.`orders` TO `test_1`@`localhost` |
+------------------------------------------------------------+
2 rows in set (0.00 sec)


```

## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`

Ответ:

```
mysql> SET profiling = 1;
Query OK, 0 rows affected, 1 warning (0.00 sec)

mysql> SELECT ENGINE FROM information_schema.TABLES WHERE table_name = 'orders';
+--------+
| ENGINE |
+--------+
| InnoDB |
+--------+
1 row in set (0.00 sec)

mysql> ALTER TABLE orders ENGINE = MyISAM;
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE orders ENGINE = InnoDB;
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> show profiles;
+----------+------------+--------------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                    |
+----------+------------+--------------------------------------------------------------------------+
|        1 | 0.00130275 | SELECT ENGINE FROM information_schema.TABLES WHERE table_name = 'orders' |
|        2 | 0.02994425 | ALTER TABLE orders ENGINE = MyISAM                                       |
|        3 | 0.03200125 | ALTER TABLE orders ENGINE = InnoDB                                       |
+----------+------------+--------------------------------------------------------------------------+
3 rows in set, 1 warning (0.00 sec)

```

## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.

Ответ:

Файл [my.cnf](DZ_6.3/src/my.cnf)

Ниже, добавленные опции:
```
innodb-flush-log-at-trx-commit=0
innodb_file_per_table=1
innodb_file_format=Barracuda
#при создании таблиц ROW_FORMAT=COMPRESSED
innodb_log_buffer_size	= 1M
innodb_buffer_pool_size = 2400M
max_binlog_size	= 100M
```