
-- ============================================
-- 2. Топ-5 самых продаваемых книг (аналитика)
-- Группировка, агрегация, сортировка
-- ============================================

SELECT 
    book.title AS 'название',
    author.name_author AS 'автор',
    SUM(buy_book.amount) AS 'всего продано'
FROM book
    INNER JOIN buy_book ON book.book_id = buy_book.book_id
    INNER JOIN author ON book.author_id = author.author_id
GROUP BY book.book_id, book.title, author.name_author
ORDER BY SUM(buy_book.amount) DESC
LIMIT 5;

-- ============================================
-- 3. Общая выручка по жанрам (оконная функция)
-- Показывает, какие жанры приносят больше денег
-- ============================================

SELECT 
    genre.name_genre AS 'жанр',
    SUM(buy_book.amount * buy_book.price) AS 'выручка',
    RANK() OVER (ORDER BY SUM(buy_book.amount * buy_book.price) DESC) AS 'место'
FROM book
    INNER JOIN buy_book ON book.book_id = buy_book.book_id
    INNER JOIN genre ON book.genre_id = genre.genre_id
GROUP BY genre.name_genre;
