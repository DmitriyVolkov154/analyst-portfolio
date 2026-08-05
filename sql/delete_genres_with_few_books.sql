-- Задача: Удалить жанры, к которым относится меньше 4 книг,
-- а у книг этих жанров установить genre_id = NULL.
-- 
-- Логика:
-- 1. Находим жанры с количеством книг < 4 (через GROUP BY + HAVING)
-- 2. Обнуляем genre_id в book для этих жанров (чтобы не нарушить связь)
-- 3. Удаляем сами жанры из genre

-- Проверочный запрос: какие жанры будут удалены
SELECT 
    genre_id,
    (SELECT name_genre FROM genre g WHERE g.genre_id = b.genre_id) AS name_genre,
    COUNT(book_id) AS book_count
FROM book b
WHERE genre_id IS NOT NULL
GROUP BY genre_id
HAVING COUNT(book_id) < 4;

-- Обнуляем genre_id в book
UPDATE book
SET genre_id = NULL
WHERE genre_id IN (
    SELECT genre_id
    FROM (
        SELECT genre_id
        FROM book
        WHERE genre_id IS NOT NULL
        GROUP BY genre_id
        HAVING COUNT(book_id) < 4
    ) AS genres_to_delete
);

-- Удаляем жанры
DELETE FROM genre
WHERE genre_id IN (
    SELECT genre_id
    FROM (
        SELECT genre_id
        FROM book
        WHERE genre_id IS NOT NULL
        GROUP BY genre_id
        HAVING COUNT(book_id) < 4
    ) AS genres_to_delete
);

-- Проверка
SELECT * FROM genre;
SELECT * FROM book;
