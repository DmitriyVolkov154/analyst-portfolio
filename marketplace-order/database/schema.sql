-- Marketplace Order: учебная модель данных

CREATE TABLE customer (
    customer_id BIGINT PRIMARY KEY
);

CREATE TABLE product (
    product_id BIGINT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    current_price DECIMAL(12,2) NOT NULL,
    available_quantity INT NOT NULL
);

CREATE TABLE orders (
    order_id BIGINT PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    status VARCHAR(30) NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    payment_deadline TIMESTAMP NOT NULL,
    cancellation_reason VARCHAR(500),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE order_item (
    order_item_id BIGINT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE delivery (
    delivery_id BIGINT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    address VARCHAR(500),
    delivery_date TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE payment (
    payment_id BIGINT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    idempotency_key VARCHAR(255) NOT NULL UNIQUE,
    status VARCHAR(30) NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE processed_events (
    event_id VARCHAR(255) PRIMARY KEY,
    event_type VARCHAR(100) NOT NULL,
    processed_at TIMESTAMP NOT NULL
);
