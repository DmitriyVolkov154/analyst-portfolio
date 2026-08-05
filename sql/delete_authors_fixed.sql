-- Задача: Удалить авторов и их книги, если общее количество книг < 20.
-- 
-- Логика:
-- 1. Находим авторов с общим количеством книг < 20
-- 2. Удаляем книги этих авторов
-- 3. Удаляем самих авторов
-- 
-- Особенность: Используем двойной подзапрос, чтобы избежать ошибки MySQL 1093

-- Проверочный запрос: какие авторы будут удалены
SELECT 
    author_id,
    name_author,
    (SELECT IFNULL(SUM(amount), 0) FROM book WHERE author_id = author.author_id) AS total_books
FROM author
HAVING total_books < 20;

-- Удаляем книги
DELETE FROM book
WHERE author_id IN (
    SELECT author_id
    FROM (
        SELECT author_id
        FROM author
        WHERE (SELECT IFNULL(SUM(amount), 0) FROM book WHERE author_id = author.author_id) < 20
    ) AS authors_to_delete
);

-- Удаляем авторов
DELETE FROM author
WHERE author_id IN (
    SELECT author_id
    FROM (
        SELECT author_id
        FROM author
        WHERE (SELECT IFNULL(SUM(amount), 0) FROM book WHERE author_id = author.author_id) < 20
    ) AS authors_to_delete
);

-- Проверка
SELECT * FROM author;
SELECT * FROM book;
