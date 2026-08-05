-- Задача: Пронумеровать заказы каждого покупателя по дате создания
-- и показать разницу в сумме между текущим и предыдущим заказом.
-- Это демонстрирует навыки работы с оконными функциями (ROW_NUMBER, LAG)
-- и обобщенными табличными выражениями (CTE).

WITH order_data AS (
    SELECT 
        o.order_id,
        o.customer_id,
        o.order_date,
        o.total_amount,
        -- Присваиваем номер заказу внутри каждого клиента (самый свежий = 1)
        ROW_NUMBER() OVER (PARTITION BY o.customer_id ORDER BY o.order_date DESC) AS order_sequence,
        -- Сумма предыдущего заказа для этого клиента
        LAG(o.total_amount, 1, 0) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS previous_order_amount
    FROM 
        orders o
    WHERE 
        o.order_status != 'CANCELLED' -- Игнорируем отменённые заказы
)

SELECT 
    customer_id,
    order_id,
    order_date,
    total_amount,
    order_sequence,
    CASE 
        WHEN previous_order_amount = 0 THEN 'Первый заказ'
        WHEN total_amount > previous_order_amount THEN 'Сумма выросла'
        WHEN total_amount < previous_order_amount THEN 'Сумма упала'
        ELSE 'Сумма не изменилась'
    END AS dynamics
FROM order_data
ORDER BY customer_id, order_date DESC;
