CREATE DATABASE happyart;

CREATE TABLE type (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO type (name) VALUES 
('Diary'),
('Notebook'),
('Drawing Notebook'),
('Keychain Sticky Notes'),
('Bookmarks Set'),
('Stickers Set'),
('Wall Calendar'),
('Magnet Calendar'),
('Magnetic Fridge'),
('Painting'),
('Resined Painting');

CREATE TABLE theme (
    id SERIAL PRIMARY KEY,
    name JSONB NOT NULL DEFAULT '{}'
);

INSERT INTO theme (name) VALUES 
 ('{ "name": ["Harry Potter", "ハリー・ポッター"] }'),
('{ "name": ["One Piece", "ワンピース"] }'),
('{ "name": ["My Hero Academia", "僕のヒーローアカデミア"] }'),
('{ "name": ["Totoro", "トトロ"] }'),
('{ "name": ["Studio Ghibli", "スタジオジブリ"] }'),
('{ "name": ["Pokemon", "ポケモン"] }'),
('{ "name": ["Sailor Moon", "セーラームーン"] }'),
('{ "name": ["Attack on Titan", "進撃の巨人"] }'),
('{ "name": ["Dragon Ball", "ドラゴンボール"] }'),
('{ "name": ["Demon Slayer", "鬼滅の刃"] }'),
('{ "name": ["Evangelion", "エヴァンゲリオン"] }'),
('{ "name": ["Star Wars"] }'),
('{ "name": ["Naruto", "ナルト"] }');

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL DEFAULT 'Sin descripción',
    price NUMERIC(10, 2) NOT NULL DEFAULT 0.00,
    stock INT NOT NULL DEFAULT 0,
    other_attributes JSONB NOT NULL DEFAULT '{}',
    type_id INT REFERENCES type(id),
    theme_id INT REFERENCES theme(id),
    img TEXT NOT NULL DEFAULT 'Sin imagen'
);


INSERT INTO products (description, price, stock, other_attributes, type_id, theme_id, img) VALUES
('Diario con diseño de Naruto', 12990, 20, '{"size": "A5", "sheets": 100, "sheet_type": "rayado", "laminate": "mate", "gr": 150}', 21, 13, 'https://www.ecartelera.com/carteles-series/300/380/001_p.jpg'),
('Cuaderno de dibujo inspirado en Totoro', 9990, 18, '{"size": "A4", "sheets": 50, "sheet_type": "liso", "laminate": "mate", "gr": 80}', 23, 4, 'https://www.ecartelera.com/carteles-series/300/380/001_p.jpg'),
('Cuaderno con diseño de One Piece', 9990, 30, '{"size": "A4", "sheets": 80, "sheet_type": "liso", "laminate": "mate", "gr": 100}', 22, 2, 'https://www.ecartelera.com/carteles-series/300/380/001_p.jpg'),
('Diario de Harry Potter con detalles dorados', 13990, 100, '{"size": "A5", "sheets": 120, "sheet_type": "cuadrícula", "laminate": "brillante", "gr": 160}', 21, 1, 'https://www.ecartelera.com/carteles-series/300/380/001_p.jpg');


CREATE TABLE users (
    userId SERIAL PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, 
    phone VARCHAR(15) NOT NULL,
    addresses TEXT NOT null,
    role VARCHAR(6) NOT NULL DEFAULT 'client'
);

INSERT INTO users (firstname, lastname, email, password, phone, addresses, role) VALUES 
('Masako', 'Kimura',
'administrador@happyart.com', 
'$2a$10$dMonR3uRrwUgoUhUXgUlduB2DmborpKnu8ELgeOoWz.rGC17n7cY6', 
'+56986351581',
'[{"tipo": "casa", "direccion": "123 Calle Principal, Santiago"}, {"tipo": "trabajo", "direccion": "456 Avenida Secundaria, Santiago"}]', 
'admin') RETURNING *;