CREATE TABLE IF NOT EXISTS Product(
    maker VARCHAR(50) NOT NULL,
    model VARCHAR(50) PRIMARY KEY,
    type VARCHAR(10) NOT NULL CHECK (type IN ('PC', 'Laptop', 'Printer'))
    );

CREATE TABLE IF NOT EXISTS PC (
    code SERIAL PRIMARY KEY,
    model VARCHAR(50) NOT NULL REFERENCES Product(model) ON DELETE CASCADE,
    speed INT NOT NULL,
    ram INT NOT NULL,
    hd INT NOT NULL,
    cd VARCHAR(10),
    price INT NOT NULL
    );

CREATE TABLE IF NOT EXISTS Laptop (
    code SERIAL PRIMARY KEY,
    model VARCHAR(50) NOT NULL REFERENCES Product(model) ON DELETE CASCADE,
    speed INT NOT NULL,
    ram INT NOT NULL,
    hd INT NOT NULL,
    price INT NOT NULL,
    screen REAL NOT NULL
    );

CREATE TABLE IF NOT EXISTS Printer (
    code SERIAL PRIMARY KEY,
    model VARCHAR(50) NOT NULL REFERENCES Product(model) ON DELETE CASCADE,
    color CHAR(1) CHECK (color IN ('y', 'n')),
    type VARCHAR(10) CHECK (type IN ('Laser', 'Jet', 'Matrix')),
    price INT NOT NULL
    );

-- Упражрение 1
SELECT model, speed, hd
FROM PC
WHERE price < 500;

-- Упражнение 2
SELECT DISTINCT maker
FROM product
WHERE type = 'Printer';

-- Упражнение 3
SELECT model, ram, screen
FROM laptop
WHERE price > 1000;

-- Упражнение 4
SELECT *
FROM printer
WHERE color = 'y';

-- Упражнение 5
SELECT model, speed, hd
FROM pc
WHERE (cd = '12x' OR cd = '24x') AND price < 600;

-- Упражнение 6
SELECT DISTINCT maker, speed
FROM product
JOIN laptop ON product.model = laptop.model
WHERE type = 'Laptop' AND hd >= 10;

-- Упражнение 7
SELECT DISTINCT model, price
FROM pc
WHERE model IN (SELECT model FROM product WHERE maker = 'ASUS')
UNION ALL
SELECT DISTINCT model, price
FROM laptop
WHERE model IN (SELECT model FROM product WHERE maker = 'ASUS')
UNION ALL
SELECT DISTINCT model, price
FROM printer
WHERE model IN (SELECT model FROM product WHERE maker = 'ASUS');

-- Упражнение 8
SELECT DISTINCT maker
FROM product
WHERE type = 'PC' AND maker NOT IN (SELECT maker FROM product WHERE type = 'Laptop');

-- Упражнение 9
SELECT DISTINCT maker
FROM product
JOIN pc ON product.model = pc.model
WHERE speed >= 450;

-- Упражнение 10
SELECT model, price
FROM Printer
WHERE price = (SELECT MAX(price) FROM Printer);