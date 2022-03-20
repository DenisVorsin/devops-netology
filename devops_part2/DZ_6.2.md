# ДЗ 6.2. SQL. Ворсин Денис

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

Ответ:

```yaml
version: '3.3'
services:
  db:
    image: postgres:12.10-bullseye
    container_name: postgres_1
    restart: always
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
    ports:
      - '5432:5432'
    volumes:
      - ./db:/var/lib/postgresql/data
      - ./backup:/var/lib/postgresql/backup

```

## Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db

Ответ:

[init_db.sql](DZ_6.2/src/init_db.sql)
```
$ docker exec -ti postgres_1 psql -U postgres -f /var/lib/postgresql/scripts/init_db.sql
DROP DATABASE
CREATE DATABASE
You are now connected to database "test_db" as user "postgres".
DROP ROLE
DROP ROLE
CREATE ROLE
CREATE ROLE
CREATE TABLE
CREATE TABLE
GRANT
GRANT
GRANT
GRANT



test_db=#  \l
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 

test_db=# \d
 public | clients | table | postgres
 public | orders  | table | postgres


test_db=# \d clients
 id       | integer |           | not null | 
 lastname | text    |           |          | 
 country  | text    |           |          | 
 booking  | integer |           |          | 

test_db=# \d orders
 id          | integer |           | not null | 
 description | text    |           |          | 
 price       | integer |           |          | 

test_db=# select * from information_schema.table_privileges where grantee in ('test-admin-user','test-simple-user');
 postgres | test-admin-user  | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-admin-user  | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | orders     | TRIGGER        | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-admin-user  | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | DELETE         | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRUNCATE       | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | REFERENCES     | NO           | NO
 postgres | test-admin-user  | test_db       | public       | clients    | TRIGGER        | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
 postgres | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
 postgres | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO

test_db=# \du
 postgres         | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 test-admin-user  | Cannot login                                               | {}
 test-simple-user | Cannot login                                               | {}


```

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

Ответ:

[Create_dataset_1.sql](DZ_6.2/src/create_dataset_1.sql)
```
$ docker exec -ti postgres_1 psql -U postgres -f /var/lib/postgresql/scripts/create_dataset_1.sql
You are now connected to database "test_db" as user "postgres".
INSERT 0 5
INSERT 0 5



test_db=# select count(*) from clients;
     5

test_db=# select count(*) from orders;
     5


```


## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказк - используйте директиву `UPDATE`.

Ответ:

SQL-запросы для выполнения данных операций: [update_dataset_1.sql](DZ_6.2/src/update_dataset_1.sql)
```
$ docker exec -ti postgres_1 psql -U postgres -f /var/lib/postgresql/scripts/update_dataset_1.sql
You are now connected to database "test_db" as user "postgres".
UPDATE 1
UPDATE 1
UPDATE 1

test_db=# select * from clients where booking is not null;
 id |       lastname       | country | booking 
----+----------------------+---------+---------
  1 | Иванов Иван Иванович | USA     |       3
  2 | Петров Петр Петрович | Canada  |       4
  3 | Иоганн Себастьян Бах | Japan   |       5
(3 rows)


```

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.

```
test_db=# explain select * from clients where booking is not null;
                        QUERY PLAN                         
-----------------------------------------------------------
 Seq Scan on clients  (cost=0.00..18.10 rows=806 width=72)
   Filter: (booking IS NOT NULL)
(2 rows)

test_db=# explain (format json) select * from clients where booking is not null;
               QUERY PLAN                
-----------------------------------------
 [                                      +
   {                                    +
     "Plan": {                          +
       "Node Type": "Seq Scan",         +
       "Parallel Aware": false,         +
       "Relation Name": "clients",      +
       "Alias": "clients",              +
       "Startup Cost": 0.00,            +
       "Total Cost": 18.10,             +
       "Plan Rows": 806,                +
       "Plan Width": 72,                +
       "Filter": "(booking IS NOT NULL)"+
     }                                  +
   }                                    +
 ]
(1 row)

Отсюда: https://postgrespro.ru/docs/postgrespro/9.5/using-explain
"Startup Cost": 0.00 - Приблизительная стоимость запуска. Это время, которое проходит, прежде чем начнётся этап вывода данных, например для сортирующего узла это время сортировки.
"Total Cost": 18.10 - Приблизительная общая стоимость. Она вычисляется в предположении, что узел плана выполняется до конца, то есть возвращает все доступные строки. На практике родительский узел может досрочно прекратить чтение строк дочернего
"Plan Rows": 806 - Ожидаемое число строк, которое должен вывести этот узел плана. При этом так же предполагается, что узел выполняется до конца.
"Plan Width": 72 - Ожидаемый средний размер строк, выводимых этим узлом плана (в байтах).


```

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления. 

Ответ:
```
#бекап всего постгреса
$ docker exec -ti postgres_1 pg_dumpall -U postgres -f /var/lib/postgresql/backup/dumpall_test_db.sql

#остановил первый постгрес
$ docker-compose down
Stopping postgres_1 ... done
Removing postgres_1 ... done
Removing network src_default
#
#отредактировал docker-compose.yaml
#запустил второй постгрес.
$ docker-compose up -d
Creating network "src_default" with the default driver
Creating postgres_2 ... done
#загрузил бекап.
$ docker exec -ti postgres_2 psql -U postgres -f /var/lib/postgresql/backup/dumpall_test_db.sql

```
[restore.log](DZ_6.2/src/restore.log)