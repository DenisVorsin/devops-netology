# ДЗ 6.1. Типы и структура СУБД. Ворсин Денис

## Задача 1
Архитектор ПО решил проконсультироваться у вас, какой тип БД лучше выбрать для хранения определенных данных.

Он вам предоставил следующие типы сущностей, которые нужно будет хранить в БД:

- Электронные чеки в json виде
- Склады и автомобильные дороги для логистической компании
- Генеалогические деревья
- Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации
- Отношения клиент-покупка для интернет-магазина

Выберите подходящие типы СУБД для каждой сущности и объясните свой выбор.

### Ответ: 

```
1. Электронные чеки в формате json - документы, следовательно субд - документоориентированная. например mongodb 
2. склады - узлы, автодороги - связи между узлами. Возможно тут подоёдет графовая субд. например Neo4j или WhiteDB
3. генеалогические деревья - структура в виде родитель-потомок, иерархическая структура, следовательно - Иерархическая субд. 
под иерархическую структуру подходят файловые система или сервера каталогов (Active directory или OpenLDAP)
но проще всего наверно использовать какой нибудь postgresql. 
4. кэш с временем жизни - redis. 
5. отношения - реляционная субд. например oracle или postgresql

Так же, наверно следует отметить что использование какие-то специфических субд, которые редко встречаются, может быть проблематично,
т.к. сложно найти соответствующего специалиста. 

```

## Задача 2
Вы создали распределенное высоконагруженное приложение и хотите классифицировать его согласно CAP-теореме. Какой классификации по CAP-теореме соответствует ваша система, если (каждый пункт - это отдельная реализация вашей системы и для каждого пункта надо привести классификацию):

- Данные записываются на все узлы с задержкой до часа (асинхронная запись)
- При сетевых сбоях, система может разделиться на 2 раздельных кластера
- Система может не прислать корректный ответ или сбросить соединение

А согласно PACELC-теореме, как бы вы классифицировали данные реализации?

### Ответ: 

```
1. согласно CAP - минус С, тоесть AP, согласно pacelc - Асинхронная значит какое-то время может быть не консистентной, тоесть PC/EL
2. согласно CAP - минус P, тоесть AC, согласно pacelc - минус консистентность, всегда доступна т.е. PА/EL
3. согласно CAP - минус A, тоесть PC, согласно pacelc - минус доступность, - PC/EC

```


## Задача 3
Могут ли в одной системе сочетаться принципы BASE и ACID? Почему?

### Ответ: 

```
ACID - максимальная надежность, BASE - максимальная доступность. 
эти параметры могут сочетаться при использовании кеширующих прокси в тех ситуациях, где это оправдано,
Хотя в рамках одной субд это взаимоисключающие вещи.
```


## Задача 4
Вам дали задачу написать системное решение, основой которого бы послужили:

- фиксация некоторых значений с временем жизни
- реакция на истечение таймаута

Вы слышали о key-value хранилище, которое имеет механизм Pub/Sub. Что это за система? Какие минусы выбора данной системы?

### Ответ: 

```
Фиксация значений с временем жизни означает что эта система не предназначена для долговременного значения, 
данные со временем будут очищаться, тоесть это некий кэш. 
Следовательно речь идёт о чем-то вроде memcached или redis. Redis умеет pub/sub. 
Redis согласно cap теореме относится к CP, тоесть в случае возникновения проблем в сети меньшая часть может стать недоступной.
А после восстановления доступности выпавшей части целостность автоматически может быть не восстановлена. 
Это следует учитывать при проектировании.

```
