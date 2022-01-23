SELECT product_name, order_date,
date_add(order_date, INTERVAL 3 DAY) AS pay_due,
date_add(order_date, INTERVAL 1 MONTH) AS deliver_due
FROM orders;