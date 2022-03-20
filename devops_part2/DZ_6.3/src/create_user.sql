CREATE USER 'test_1'@'localhost' IDENTIFIED BY 'test-pass';
ALTER USER 'test_1'@'localhost' ATTRIBUTE '{"fname":"James", "lname":"Pretty"}';
ALTER USER 'test_1'@'localhost'
    WITH
            MAX_QUERIES_PER_HOUR 100
            PASSWORD EXPIRE INTERVAL 180 DAY
            FAILED_LOGIN_ATTEMPTS 3;
GRANT Select ON test_db.orders TO 'test_1'@'localhost';