-- Задача: Установить жанры для книг, у которых они не были указаны.
-- 
-- Логика:
-- 1. Для книги Лермонтова «Стихотворения и поэмы» находим genre_id для «Поэзия»
-- 2. Для книги Стивенсона «Остров сокровищ» находим genre_id для «Приключения»
-- 3. Обновляем genre_id в таблице book через подзапросы

-- Обновление жанра для книги Лермонтова
UPDATE book
SET genre_id = (SELECT genre_id FROM genre WHERE name_genre = 'Поэзия')
WHERE title = 'Стихотворения и поэмы' 
  AND author_id = (SELECT author_id FROM author WHERE name_author = 'Лермонтов М.Ю.');

-- Обновление жанра для книги Стивенсона
UPDATE book
SET genre_id = (SELECT genre_id FROM genre WHERE name_genre = 'Приключения')
WHERE title = 'Остров сокровищ' 
  AND author_id = (SELECT author_id FROM author WHERE name_author = 'Стивенсон Р.Л.');
