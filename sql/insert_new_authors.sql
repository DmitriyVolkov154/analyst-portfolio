-- Задача: Добавить в таблицу author авторов, которые есть в supply, но отсутствуют в author.
-- 
-- Логика:
-- 1. Находим авторов из supply, которых нет в author (через LEFT JOIN с условием IS NULL)
-- 2. Добавляем их в author через INSERT ... SELECT
-- 3. Выводим обновлённый список авторов

-- Проверочный запрос: какие авторы будут добавлены
SELECT DISTINCT s.author
FROM supply s
LEFT JOIN author a ON a.name_author = s.author
WHERE a.name_author IS NULL;

-- Основной запрос: добавление новых авторов
INSERT INTO author (name_author)
SELECT DISTINCT s.author
FROM supply s
LEFT JOIN author a ON a.name_author = s.author
WHERE a.name_author IS NULL;

-- Проверка результата
SELECT * FROM author;
