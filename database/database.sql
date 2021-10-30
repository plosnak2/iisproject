SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE address (
    id int AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    number VARCHAR(20),
    city VARCHAR(50),
    postal_code VARCHAR(5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

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

CREATE TABLE book (
    isbn VARCHAR(22) PRIMARY KEY,
    name VARCHAR(150),
    authors VARCHAR(300),
    year int(4),
    publisher VARCHAR(100),
    genre VARCHAR(100),
    rating FLOAT(2,1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

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



#Insert do tabuliek
INSERT INTO address(street, number, city, postal_code)
    VALUES ('Štúrova', '4', 'Prievidza', '64135'),
    ('Mojmírova', '75', 'Topolčany', '84409'),
    ('Staničná', '104', 'Nitra', '94920'),
    ('Trieda Andreja Hlinku', '51', 'Nové Zámky', '53202'),
    ('Akademická ulica', '42', 'Žilina', '43506'),
    ('Bernoláková ulica', '28', 'Zlaté Moravce', '81735'),
    ('Lesná', '7', 'Levice', '74318'),
    ('Lipová', '5', 'Hlohovec', '64852'),
    ('Výstavná', '9', 'Sverepec', '94901'),
    ('Horská', '31', 'Šurany', '65432'),
    ('Pod Briežkom', '26', 'Púchov', '93219'),
    ('Studničná', '8', 'Považská Bystrica', '81748');

INSERT INTO user(name, surname, mail, phone, password, role, address_id)
    VALUES ('Alex', 'Babjak', 'alex.babka11@gmail.com', '0904183951', '$2y$10$I1rqUhH/nfaipLQYX6YMFO1edFnDHNEenAWQA.tGreWtU7/imSmnW', 1,1),
    ('Hana', 'Jakabová', 'hjakabovaana@seznam.sk', '0905654789', 'hashed_pass', 3,2),
    ('Igor', 'Jurčina', 'ijurcina@centrum.sk', '0904442266', 'hashed_pass', 1,4),
    ('Anabela', 'Bednárová', 'a.bednarova@gmail.com', '0907167943', 'hashed_pass', 1,6),
    ('Ignác', 'Ker', 'igi.ker@post.sk', '0907625856', 'hashed_pass', 1,7),
    ('Boris', 'Čapka', 'bo.capka5@gmail.com', '0905856854', 'hashed_pass', 1,8),
    ('Maroš', 'Lupták', 'xlupta15@post.sk', '0915242624', 'hashed_pass', 1,9),
    ('Erika', 'Drobná', 'drobna.erika@gmail.com', '0903157984', 'hashed_pass', 1,10),
    ('Oliver', 'Zima', 'ozima@centrum.sk', '0901535743', 'hashed_pass', 1,11),
    ('Klára', 'Gašparová', 'gasparklara3@centrum.sk', '0907384729', 'hash_pass', 1,12);

INSERT INTO library(name, opening_hours, description, address_id, user_id)
    VALUES ('Mestská knižnica', '- - 07:00 18:30 07:00 18:30 07:00 18:30 07:00 18:30 08:00 17:00 08:00 17:00',
    'Zmodernizovaná knižnica v Nitre. U nás zažijete neskotučné množstvo hodín v objatí slovenskej, ale aj medzinárodnej literatúri.', 3, 2),
    ('Knižnica Juraja Fándlyho', '- - 08:30 18:00 08:30 18:00 08:30 18:00 08:30 18:00 08:30 19:00 08:00 12:00',
    'História Knižnica Juraja Fándlyho sa začala písať v roku 1983. Za tú dobu sme navýšili počty knižných titulov. V dnešnej dobe sa snažíme zaujať organizáciou rôznzch podujatí.', 5, 7);

INSERT INTO book(isbn, name, authors, year, publisher, genre, rating)
    VALUES ('9788055606354', 'Pán prsteňov I. - Spoločenstvo prsteňa', 'J.R.R. Tolkien', 2012 , 'Slovart', 'Fantasy', 4.2),
    ('9788027507535', 'Černá píseň', 'Anthony Ryan', 2021 , 'HOST', 'Fantasy', 4.1),
    ('9788022021852', 'Na západe nič nové', 'Erich Maria Remarque', 2020 , 'Slovenský spisovateľ', 'Román', 4.6),
    ('9788055155869', 'Rozprávky barda Beedla', 'J.K. Rowling', 2017 , 'IKAR', 'Román', 3.7),
    ('9788055606378', 'Hobit', 'J.R.R. Tolkien', 2012 , 'Slovart', 'Fantasy', 4.4),
    ('9788024276632', 'Mrazivé vraždy - Historky ke krbovému ohni', 'Agatha Christie', 2021 , 'Kalibr', 'Detektívky', 3.4),
    ('9788055652627', 'Bremeno minulosti', 'Dominik Dán', 2021 , 'Slovart', 'Detektívky', 4.8),
    ('9788022023375', 'Violončelistka', 'Daniel Silva', 2021 , 'Slovenský spisovateľ', 'Trilery', 2.7),
    ('9788055178714', 'Volavka', 'František Kozmon', 2021 , 'IKAR', 'Detektívky', 4.9),
    ('9788055163468', 'Kukučka', 'František Kozmon', 2018 , 'IKAR', 'Trilery', 4.7),
    ('9788055602172', 'Hlava XXII', 'Joseph Heller', 2011 , 'Slovart', 'Román', 4.5),
    ('9788022021609', 'Chrám Matky Božej v Paríži', 'Victor Hugo', 2019 , 'Slovenský spisovateľ', 'Román', 4.1),
    ('9788082340047', 'Radostná správa', 'Peter Gärtner, Ďuro Balogh', 2021 , 'Monokel', 'Komiksy', 3.9),
    ('9788088268567', 'Jágr, legenda', 'Lukáš Csicsely', 2021 , '65. pole', 'Komiksy', 3.6),
    ('9788088262176', 'Kočičí rytíř a soumrak démonů', 'Jie Jü-tchung', 2021 , 'Mi:Lu Publishing', 'Komiksy', 2.4),
    ('9788080902100', 'Cukráreň v Paríži', 'Julie Caplin', 2021 , 'Grada', 'Spoločenská beletria', 4.1),
    ('9788082420190', 'Tak to vidím ja', 'George Orwell', 2021 , 'Premedia', 'Spoločenská beletria', 3.2),
    ('9788055645797', 'Rod zeme a krvi - Mesto Luny', 'Sarah J. Maas', 2020 , 'Slovart', 'Spoločenská beletria', 3.7),
    ('9788056603116', 'Paul McCartney', 'Philip Norman', 2017 , 'Slovart', 'Biografia', 4.0),
    ('9788056614464', 'Freddie Mercury: Ilustrovaný životopis', 'Alfonso Casas', 2019 , 'Lindeni', 'Biografia', 5.0);

INSERT INTO availability(count, book_isbn, lib_name)
    VALUES (12, '9788055606354', 'Mestská knižnica'),
    (6, '9788027507535', 'Mestská knižnica'),
    (9, '9788022021852', 'Knižnica Juraja Fándlyho'),
    (4, '9788055155869', 'Mestská knižnica'),
    (17, '9788055606378', 'Knižnica Juraja Fándlyho'),
    (5, '9788024276632', 'Knižnica Juraja Fándlyho'),
    (16, '9788055652627', 'Knižnica Juraja Fándlyho'),
    (10, '9788055652627', 'Mestská knižnica'),
    (10, '9788022023375', 'Mestská knižnica'),
    (19, '9788055178714', 'Knižnica Juraja Fándlyho'),
    (3, '9788055163468', 'Mestská knižnica'),
    (2, '9788055602172', 'Knižnica Juraja Fándlyho'),
    (7, '9788022021609', 'Mestská knižnica'),
    (13, '9788082340047', 'Knižnica Juraja Fándlyho'),
    (12, '9788088268567', 'Mestská knižnica'),
    (7, '9788088268567', 'Knižnica Juraja Fándlyho'),
    (7, '9788088262176', 'Mestská knižnica'),
    (4, '9788080902100', 'Mestská knižnica'),
    (6, '9788082420190', 'Knižnica Juraja Fándlyho'),
    (17, '9788055645797', 'Knižnica Juraja Fándlyho'),
    (11, '9788056603116', 'Mestská knižnica'),
    (0, '9788056614464', 'Knižnica Juraja Fándlyho'),
    (2, '9788056614464', 'Mestská knižnica');

INSERT INTO reservation(date_end, status, book_isbn, lib_name, user_id)
	VALUES ('2021-11-12 18:44:25', 1, '9788055606354', 'Mestská knižnica', 1),
	('2021-11-12 10:04:14', 1, '9788027507535', 'Mestská knižnica', 2),
	('2021-08-13 15:19:19', 1, '9788022021852', 'Knižnica Juraja Fándlyho', 3),
	('2021-02-19 07:36:50', 2, '9788055652627', 'Knižnica Juraja Fándlyho', 4),
	('2021-06-11 09:30:42', 1, '9788022023375', 'Mestská knižnica', 5),
	('2021-12-07 13:55:36', 2, '9788082340047', 'Knižnica Juraja Fándlyho', 6),
	('2021-10-02 17:17:17', 2, '9788082420190', 'Knižnica Juraja Fándlyho', 7),
	('2021-01-14 22:41:16', 3, '9788056614464', 'Mestská knižnica', 8),
	('2021-04-29 05:35:11', 1, '9788056603116', 'Mestská knižnica', 9),
	('2021-07-24 01:20:00', 3, '9788055645797', 'Knižnica Juraja Fándlyho', 10);

INSERT INTO votes(book_isbn, lib_name, user_id)
    VALUES ('9788088268567', 'Knižnica Juraja Fándlyho', 1),
    ('9788088268567', 'Knižnica Juraja Fándlyho', 2),
    ('9788056614464', 'Mestská knižnica', 3),
    ('9788055178714', 'Knižnica Juraja Fándlyho', 4),
    ('9788027507535', 'Mestská knižnica', 5),
    ('9788024276632', 'Knižnica Juraja Fándlyho', 6),
    ('9788082420190', 'Knižnica Juraja Fándlyho', 7),
    ('9788088262176', 'Mestská knižnica', 8),
    ('9788022023375', 'Mestská knižnica', 9),
    ('9788055645797', 'Knižnica Juraja Fándlyho', 10);

INSERT INTO orders(count, book_isbn, lib_name, user_id)
    VALUES (1, '9788055645797', 'Knižnica Juraja Fándlyho', 1),
    (1, '9788027507535', 'Mestská knižnica', 2),
    (2, '9788055606378', 'Knižnica Juraja Fándlyho', 3),
    (4, '9788022021609', 'Mestská knižnica', 4),
    (3, '9788088268567', 'Mestská knižnica', 5),
    (1, '9788024276632', 'Knižnica Juraja Fándlyho', 6),
    (2, '9788088268567', 'Knižnica Juraja Fándlyho', 7),
    (1, '9788088262176', 'Mestská knižnica', 8),
    (2, '9788080902100', 'Mestská knižnica', 9),
    (3, '9788056603116', 'Mestská knižnica', 10);

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

drop table address;
drop table user;
drop table library;
drop table book;
drop table availability;
drop table reservation;
drop table votes;
drop table orders;
SET FOREIGN_KEY_CHECKS=1;