# ДЗ 6.4. PostgreSQL. Ворсин Денис

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql

### Ответ:

Для запуска контейнера использован [docker-compose.yaml](DZ_6.4/src/docker-compose.yaml)
```
вывода списка БД - \l[+]   [PATTERN] 
подключения к БД -  \c[onnect] {[DBNAME|- USER|- HOST|- PORT|-] | conninfo} 
вывода списка таблиц -  \d[S+] 
вывода описания содержимого таблиц - \d[S+]  NAME 
выхода из psql -  \q 

```


## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

### Ответ:
```


test_database=# select tablename,attname,avg_width from pg_stats where tablename='orders';
 tablename | attname | avg_width 
-----------+---------+-----------
 orders    | id      |         4
 orders    | title   |        16
 orders    | price   |         4
(3 rows)

```
## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

### Ответ:

```
test_database=# alter table orders rename to orders_full;
ALTER TABLE
test_database=# create table orders (id integer NOT NULL, title character varying(80) NOT NULL, price integer DEFAULT 0 ) partition by range(price);
CREATE TABLE
test_database=# create table orders_1 partition of orders for values from (0) to (499);
CREATE TABLE
test_database=# create table orders_2 partition of orders for values from (499) to (9999999);
CREATE TABLE
test_database=# insert into orders (id, title, price) select * from orders_full;
INSERT 0 8

При проектировании можно было сразу заложить партиционирование, тогде не пришлось бы переносить данные вручную.

```

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

### Ответ:
[Database dump](devops_part2/DZ_6.4/src/dump_test_database.sql)
```
Для обеспечения уникальности в создание таблиц orders можно добавить 
UNIQUE(title)
```