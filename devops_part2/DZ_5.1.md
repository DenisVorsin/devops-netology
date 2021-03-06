# ДЗ 5.1. Введение в виртуализацию, Ворсин Денис

## Задача 1
Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.

Ответ:
```
Отличие в том, на каком уровне нужна полноценная ОС.
если нужна полноценная ОС на уровне виртуальных серверов - аппаратная виртуализация.
Если на уровне виртуальных серверов полноценная ОС не нужна, задачи однотипные - виртуализация на основе ОС.
если и базовая система и виртуальная нужны полноценные ОС - паравиртуализация. 
update:
при полной виртуализации ядро гостевой системы не изменяется, 
а при паравиртуализации ядро гостевой системы изменяется, система знает что она в виртальной среде и знает 
как обратиться к хостовой за определёнными системными функциями.   
```

## Задача 2
Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.

Организация серверов:
- физические сервера,
- паравиртуализация,
- виртуализация уровня ОС. 
 
Условия использования:
1. Высоконагруженная база данных, чувствительная к отказу.
2. Различные web-приложения.
3. Windows системы для использования бухгалтерским отделом.
4. Системы, выполняющие высокопроизводительные расчеты на GPU.
Опишите, почему вы выбрали к каждому целевому использованию такую организацию.

Ответ:
```
1. Для высоконагруженных СУБД, чувствительных к отказу возможно выгоднее использовать 
аппаратную виртуализацию, например vmware vsphere, т.к.
для СУБД требуется полноценная ОС и максимальная доступность всех аппаратных ресурсов.
VMware ESXi для ВМ есть паравиртуальный SCSI адаптер PVSCSI, 
позволяющий повысить общую производительность для ВМ с интенсивными дисковыми операциями, 
как например нагруженные СУБД
2. Для веб-приложений можно выбрать виртуализацию на основе ОС, т.к. сами по себе веб-приложения
полноценную ОС в качестве виртуальной не требуют,
достаточно легковесны, однотипны, относительно просто масштабируются, но их обычно очень много.
3. Windows-системы для использования бухгалтеских программ требуют полноценную ОС в качестве виртуальной
и полноценную ОС в качестве базовой системы для удобства администрирования.
Если пользователей единицы, а приложения не сильно ресурсоёмки - можно использовать паравиртуализацию.  
если пользователей десятки и сотни, тут потребуется полноценная виртуализация.
4. Для высокопроизводительных рассчетов требуется прямой и исключительный доступ к вычислительным ресурсам,
некоторые средства виртуализации могут дать прямой доступ, но возможно будет проще использовать
выделенный физический сервер под такие задачи.

```

## Задача 3
Выберите подходящую систему управления виртуализацией для предложенного сценария. 
Детально опишите ваш выбор.

Сценарии:

1. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.
2. Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.
3. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.
4. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.

Ответ:
```
1. поскольку достаточно много виртуальных машин, различных типов ОС, под различные задачи, 
если есть возможность то vmware vspherе 
2. предположим что под "наибольшей производительностью" подразумеваются ML вычисления
и т.к. Xen HVM умеет VGA Passthrough, то остановим выбор на Xen 
3. Для окружения Windows предпочтительнее использовать Hyper-V, 
но т.к. решение нужно бесплатное, то KVM, поскольку он считается стандартом среди бесплатных решений
4. virtualbox - удобное средство для развёртывания тестовых сред на собственном ПК. 
Если требуется среда покрупнее и на одном ПК не влезает - можно использовать proxmox. 

```

## Задача 4
Опишите возможные проблемы и недостатки гетерогенной среды виртуализации 
(использования нескольких систем управления виртуализацией одновременно) 
и что необходимо сделать для минимизации этих рисков и проблем. 
Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? 
Мотивируйте ваш ответ примерами.

Ответ:
```
В гетерогенной среде каждый гипервизор управляет своим пулом ресурсов, 
нет возможности переносить нагрузку между различными гипервизорами,
каждый гипервизор имеет свои настройки доступа.
При этом для ОС Windows, бухгалтерского ПО предпочтительнее использовать Hyper-V
Для сервисов на Linux предпочтительнее использовать KVM или Proxmox
Использовать гетерогенную среду или нет - зависит от масштабов среды и бизнес-потребностей.
Если нагрузка не загружает серверы то выносить её в отдельный гипервизор смысла нет. 
```
