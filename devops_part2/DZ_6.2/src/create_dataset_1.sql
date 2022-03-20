\c test_db;
insert into orders (id, description, price)
      VALUES
            (1, 'Шоколад', 10),
            (2, 'Принтер', 3000),
            (3, 'Книга', 500),
            (4, 'Монитор', 7000),
            (5, 'Гитара', 4000);
insert into clients (id, lastname, country)
      VALUES
            (1, 'Иванов Иван Иванович', 'USA'),
            (2, 'Петров Петр Петрович', 'Canada'),
            (3, 'Иоганн Себастьян Бах', 'Japan'),
            (4, 'Ронни Джеймс Дио', 'Russia'),
            (5, 'Ritchie Blackmore', 'Russia');

