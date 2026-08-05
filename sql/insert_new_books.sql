-- Задача: Добавить в таблицу book новые книги из supply,
-- которых ещё нет в book (по названию и автору).
-- 
-- Логика:
-- 1. Находим книги из supply, у которых автор уже есть в author
-- 2. Исключаем книги, которые уже есть в book (LEFT JOIN ... IS NULL)
-- 3. Добавляем их через INSERT ... SELECT

-- Проверочный запрос: какие книги будут добавлены
SELECT 
    s.title,
    a.name_author,
    s.price,
    s.amount
FROM 
    supply s
INNER JOIN 
    author a ON a.name_author = s.author
LEFT JOIN 
    book b ON b.title = s.title AND b.author_id = a.author_id
WHERE 
    b.book_id IS NULL;

-- Основной запрос: добавление новых книг
INSERT INTO book (title, author_id, genre_id, price, amount)
SELECT 
    s.title,
    a.author_id,
    NULL AS genre_id,  -- жанр не указан в supply
    s.price,
    s.amount
FROM 
    supply s
INNER JOIN 
    author a ON a.name_author = s.author
LEFT JOIN 
    book b ON b.title = s.title AND b.author_id = a.author_id
WHERE 
    b.book_id IS NULL;

-- Проверка результата
SELECT * FROM book;
