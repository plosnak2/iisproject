SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE address (
    id int AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    number VARCHAR(20),
    city VARCHAR(50),
    postal_code VARCHAR(5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

INSERT INTO address(street, number, city, postal_code)
VALUES ('Sverepec', '515', 'Považska Bystrica', '01701');
INSERT INTO address(street, number, city, postal_code)
VALUES ('Mojzesova', '666', 'Havaj', '02121');


CREATE TABLE user (
    id int AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    surname VARCHAR(30) NOT NULL,
    mail VARCHAR(50),
    phone VARCHAR(10),
    password VARCHAR(50),
    role int(1),
    address_id int,
    constraint fk_address FOREIGN KEY (address_id)
                   REFERENCES address(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

INSERT INTO user(name, surname, mail, phone, password, role, address_id)
VALUES ('Maroš', 'Kramar', 'marosko.klamar@gmail.com', '0902504817', 'hashed_pass', 0,1);

INSERT INTO user(name, surname, mail, phone, password, role, address_id)
 VALUES ('Klara', 'Divna', 'klara@centrum.sk', '090250487', 'hash_psssss', 1,2);

CREATE TABLE library (
    name VARCHAR(200) PRIMARY KEY,
    opening_hours VARCHAR(200),
    description VARCHAR(1000),
    address_id int,
    constraint fk_address_lib FOREIGN KEY (address_id)
                   REFERENCES address(id),
    user_id int,
    constraint fk_user_lib FOREIGN KEY (user_id)
                   REFERENCES user(id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

INSERT INTO library(name, opening_hours, description, address_id, user_id)
VALUES ('Karlova kniznica', '- - 08:00 18:00 08:00 18:00 08:00 18:00 08:00 18:00 08:00 18:00 08:00 18:00',
'Krasna kniznica', 1, 2);

CREATE TABLE book (
    isbn VARCHAR(22) PRIMARY KEY,
    name VARCHAR(150),
    authors VARCHAR(300),
    year int(4),
    publisher VARCHAR(100),
    genre VARCHAR(100),
    rating FLOAT(2,1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

INSERT INTO book(isbn, name, authors, year, publisher, genre, rating)
VALUES ('97912345123564', 'Pán prsteňov', 'Peter Jonáš, Martin Veget', 1957 , 'IKAR', 'Detektivka', 2.50);

CREATE TABLE availability (
    id int AUTO_INCREMENT PRIMARY KEY,
    count int(10),
    book_isbn VARCHAR(22),
    constraint fk_avail_book FOREIGN KEY (book_isbn)
                   REFERENCES book(isbn),
    lib_name VARCHAR(200),
    constraint fk_avail_lib FOREIGN KEY (lib_name)
                   REFERENCES library(name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

INSERT INTO availability(count, book_isbn, lib_name)
VALUES (12, '97912345123564', 'Karlova kniznica');

CREATE TABLE reservation(
    id int AUTO_INCREMENT PRIMARY KEY,
    date_end DATETIME,
    status int(1),
    book_isbn VARCHAR(22),
    constraint fk_res_book FOREIGN KEY (book_isbn)
                   REFERENCES book(isbn),
    lib_name VARCHAR(200),
    constraint fk_res_lib FOREIGN KEY (lib_name)
                   REFERENCES library(name),
    user_id int,
    constraint fk_res_user FOREIGN KEY (user_id)
                   REFERENCES user(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;


INSERT INTO reservation(date_end, status, book_isbn, lib_name, user_id)
VALUES ('2021-11-12 18:44:25', 0, '97912345123564', 'Karlova kniznica', 1);

CREATE TABLE votes(
    id int AUTO_INCREMENT PRIMARY KEY,
    book_isbn VARCHAR(22),
    constraint fk_votes_book FOREIGN KEY (book_isbn)
                   REFERENCES book(isbn),
    lib_name VARCHAR(200),
    constraint fk_votes_lib FOREIGN KEY (lib_name)
                   REFERENCES library(name),
    user_id int,
    constraint fk_votes_user FOREIGN KEY (user_id)
                   REFERENCES user(id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

INSERT INTO votes(book_isbn, lib_name, user_id)
VALUES ('97912345123564', 'Karlova kniznica', 1);

CREATE TABLE orders(
    id int AUTO_INCREMENT PRIMARY KEY,
    count int(100),
    book_isbn VARCHAR(22),
    constraint fk_order_book FOREIGN KEY (book_isbn)
                   REFERENCES book(isbn),
    lib_name VARCHAR(200),
    constraint fk_order_lib FOREIGN KEY (lib_name)
                   REFERENCES library(name),
    user_id int,
    constraint fk_order_user FOREIGN KEY (user_id)
                   REFERENCES user(id)

) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;


INSERT INTO orders(count, book_isbn, lib_name, user_id)
VALUES (15, '97912345123564', 'Karlova kniznica', 2);


/*
SELECT EXISTS(SELECT * from votes WHERE user_id=2);
*/

/* zistenie počtu knih v danej kniznici
SELECT count FROM availability
WHERE availability.lib_name = 'Karlova kniznica'
   and availability.book_isbn = '97912345123564';
*/

/*zistenie adresy uzivatela
SELECT user.id, address.id, address.city, address.number, address.postal_code, address.street FROM address
JOIN user on address.id = user.address_id
HAVING user.id = 3;*/

/* pre zmenu adresy uzivatela / kniznice
UPDATE address
SET city = 'Praznov'
WHERE address.id = 5;*/


SELECT * from address;
SELECT * from user;
SELECT * from library;
SELECT * from book;
SELECT * from availability;
SELECT * from reservation;
SELECT * from votes;
SELECT * from orders;

DROP table user;
DROP table address;
drop table library;
drop table book;
SET FOREIGN_KEY_CHECKS=1;