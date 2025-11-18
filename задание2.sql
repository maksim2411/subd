-- вариант 6
-- 1. создал таблицу
CREATE TABLE logs (
    log_id INT PRIMARY KEY,
    user_id INT,
    action VARCHAR(20),
    timestamp DATETIME
);

-- 2. создал таблицу 
-- поскольку скрипт в тз не работает на нашей верии я нашел альтернативу 
-- 
-- SET SESSION cte_max_recursion_depth = 400001;

-- INSERT INTO logs (log_id, user_id, action, timestamp)
-- WITH RECURSIVE numbers (n) AS (
   -- SELECT 1
   -- UNION ALL
   -- SELECT n + 1 FROM numbers WHERE n < 400000
-- )
-- SELECT 
--    n,
--    FLOOR(RAND() * 10000),
--    'login',
--    DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY)
-- FROM numbers; изначально было так ниже указал рабочий




DELIMITER $$

CREATE PROCEDURE fill_logs()
BEGIN
    DECLARE i INT DEFAULT 1;

    START TRANSACTION;

    WHILE i <= 400000 DO
        INSERT INTO logs (log_id, user_id, action, timestamp)
        VALUES (
            i,
            FLOOR(RAND() * 10000),
            'login',
            DATE_ADD('2023-01-01', INTERVAL FLOOR(RAND() * 365) DAY)
        );

        SET i = i + 1;
    END WHILE;

    COMMIT;
END $$

DELIMITER ;

CALL fill_logs();

-- 3.
-- создал индексы 

CREATE INDEX idx_user_time ON logs (user_id, timestamp);

-- 4. проверил запросом 

-- без индекса
EXPLAIN
SELECT *
FROM logs
WHERE timestamp BETWEEN '2023-01-01' AND '2023-12-31';

-- с индексом
EXPLAIN
SELECT *
FROM logs
WHERE user_id = 123
  AND timestamp BETWEEN '2023-05-01' AND '2023-05-20';