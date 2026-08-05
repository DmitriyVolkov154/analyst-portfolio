SELECT 
    b.title,
    a.name_author,
    b.price AS book_price,
    s.price AS supply_price,
    b.amount AS book_amount,
    s.amount AS supply_amount,
    ROUND((b.price * b.amount + s.price * s.amount) / (b.amount + s.amount), 2) AS new_price,
    b.amount + s.amount AS new_amount
FROM 
    book b
INNER JOIN author a ON a.author_id = b.author_id
INNER JOIN supply s ON b.title = s.title AND s.author = a.name_author
WHERE 
    b.price != s.price;


-- Задача: Обновить остатки и пересчитать цену для книг,
-- которые уже есть на складе, но поступают по другой цене от того же автора.
-- 
-- Логика:
-- 1. Находим книги с одинаковым названием и автором в book и supply
-- 2. Если цена отличается → пересчитываем количество и цену в book
-- 3. Обнуляем amount в supply для обработанных книг

-- Проверочный запрос (какие книги будут обновлены)
SELECT ...

-- Основное обновление
UPDATE book ...


  
-- 1. Обновляем книгу и обнуляем поставку (одним запросом, но с подзапросом для пересчета цены)
UPDATE book 
INNER JOIN author ON author.author_id = book.author_id
INNER JOIN supply ON book.title = supply.title 
                     AND supply.author = author.name_author
SET 
    book.amount = book.amount + supply.amount,
    book.price = ROUND((book.price * book.amount + supply.price * supply.amount) / (book.amount + supply.amount), 2),
    supply.amount = 0   
WHERE 
    book.price != supply.price;  -- обновляем только те, где цена отличается

-- 2. Проверяем результат
SELECT * FROM book;
SELECT * FROM supply;
