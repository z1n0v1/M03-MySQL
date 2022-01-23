DROP DATABASE IF EXISTS online_store;
    CREATE DATABASE IF NOT EXISTS online_store;
    USE online_store;

    CREATE TABLE item_types (
		item_type_id INT(11) NOT NULL UNIQUE PRIMARY KEY,
        name VARCHAR(50)
	);

    CREATE TABLE items (
		item_id INT(11) NOT NULL UNIQUE PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        item_type_id INT(11),
        CONSTRAINT fk_item_type FOREIGN KEY(item_type_id) REFERENCES item_types(item_type_id)
	);

    CREATE TABLE cities (
		city_id INT(11) NOT NULL UNIQUE PRIMARY KEY,
        name VARCHAR(50)
	);

    CREATE TABLE customers (
		customer_id INT(11) NOT NULL UNIQUE PRIMARY KEY,
        name VARCHAR(50),
        birthday DATE,
        city_id INT(11),
        CONSTRAINT fk_city FOREIGN KEY (city_id) REFERENCES cities(city_id)
	);

    CREATE TABLE orders (
		order_id INT(11) NOT NULL UNIQUE PRIMARY KEY,
        customer_id INT(11) NOT NULL,
        CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
	);

    CREATE TABLE order_items (
		order_id INT(11) NOT NULL,
        item_id INT(11) NOT NULL,
        CONSTRAINT pk_order_items PRIMARY KEY(order_id, item_id),
        CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
        CONSTRAINT fk_item FOREIGN KEY (item_id) REFERENCES items(item_id)
	);