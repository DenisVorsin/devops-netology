DROP DATABASE IF EXISTS test_db;
CREATE DATABASE test_db;
\c test_db;
DROP ROLE IF EXISTS "test-admin-user";
DROP ROLE IF EXISTS "test-simple-user";
CREATE ROLE "test-admin-user";
CREATE ROLE "test-simple-user";

CREATE TABLE orders
(
id integer,
description text,
price integer,
PRIMARY KEY (id)
);
CREATE TABLE clients
(
	id integer PRIMARY KEY,
	lastname text,
	country text,
	booking integer,
	FOREIGN KEY (booking) REFERENCES orders (Id)
);

GRANT ALL ON orders to "test-admin-user";
GRANT ALL ON clients to "test-admin-user";
GRANT SELECT, INSERT, UPDATE, DELETE ON orders to "test-simple-user";
GRANT SELECT, INSERT, UPDATE, DELETE ON clients to "test-simple-user";

