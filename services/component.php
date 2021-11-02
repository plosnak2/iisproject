<?php

class MainComponent
{
    private $pdo;

    // constructor that connects to the database
    function __construct()
    {
        $server = 'mysql:host=127.0.0.1;dbname=xzauko00';
        $username = 'root';
        $password = '';
        $options = array(
            PDO::MYSQL_ATTR_INIT_COMMAND => 'SET NAMES utf8',
            );
        $this->pdo = new PDO($server, $username, $password, $options);
    }

    // function that returns genres of a books (if there is multiple times same genre in database, it will only return one of them because of distinct keyword)
    function get_genres()
    {
        $answer = $this->pdo->query('SELECT DISTINCT genre FROM book');
        return $answer;
    }

    // function that returns genres of a books (if there is multiple times same genre in database, it will only return one of them because of distinct keyword)
    function get_books()
    {
        $answer = $this->pdo->query('SELECT isbn, name, authors, publisher, genre FROM book');
        return $answer;
    }

    // function that returns genres of a books (if there is multiple times same genre in database, it will only return one of them because of distinct keyword)
    function get_book($isbn)
    {
        $answer = $this->pdo->prepare('SELECT isbn, name, authors, publisher, genre, rating, year FROM book WHERE isbn=?');
        $answer->execute(array($isbn));
        return $answer->fetch();
    }

    // function that returns genres of a books (if there is multiple times same genre in database, it will only return one of them because of distinct keyword)
    function get_total_sum_of_book($isbn)
    {
        $answer = $this->pdo->prepare('SELECT SUM(count) as count FROM availability WHERE book_isbn=?');
        $answer->execute(array($isbn));
        return $answer->fetch();
    }

    //function that returns id, mail and hashed password
    function get_mail_password($mail)
    {
        $answer = $this->pdo->prepare('SELECT id, mail, password, role FROM user WHERE mail=?');
        $answer->execute(array($mail));
        return $answer->fetch();
    }

    // function that returns books with specific filter
    function get_filtered_books($select)
    {
        $answer = $this->pdo->query($select);
        return $answer;
    }

    function cancel_reservation($isbn, $lib_name, $id)
    {
        $answer = $this->pdo->prepare('UPDATE reservation SET date_end=null, status=3 WHERE book_isbn=? and lib_name=? and user_id=?;');
        $answer->execute(array($isbn, $lib_name, $id));
        return;
    }

    // function that returns libraries from database
    function get_libs()
    {
        $answer = $this->pdo->query('SELECT * FROM library');
        return $answer;
    }

    // function that returns libraries from database
    function get_num_of_books_in_lib($isbn, $lib_name)
    {
        $answer = $this->pdo->prepare('SELECT count FROM availability WHERE book_isbn=? AND lib_name=?');
        $answer->execute(array($isbn, $lib_name));
        return $answer->fetch();
    }

    // function that checks if user already has reservation on specific book
    function reservation_exists($id, $isbn)
    {
        $answer = $this->pdo->prepare('SELECT COUNT(1) as count FROM reservation WHERE user_id =? and book_isbn=? and (status=1 or status=2 or status=4);');
        $answer->execute(array($id, $isbn));
        return $answer->fetch();
    }

    // function that servers for double checking when user sends reservation
    function reservation_created($id, $isbn)
    {
        $answer = $this->pdo->prepare('SELECT COUNT(1) as count FROM reservation WHERE user_id=? and book_isbn=? and status=1');
        $answer->execute(array($id, $isbn));
        return $answer->fetch();
    }

    // function that decrement bumber of books in availability table
    function decrement_count_in_availability($isbn, $lib_name)
    {
        $answer = $this->pdo->prepare('UPDATE availability SET count = count - 1 WHERE book_isbn=? and lib_name=?;');
        $answer->execute(array($isbn, $lib_name));
        return;
    }

    function delete_from_reservations($id_res)
    {
        $answer = $this->pdo->prepare('DELETE FROM reservation WHERE id=?;');
        $answer->execute(array($id_res));
        return;
    }

    // function that returns all reservation of specific user
    function get_user_reservations($id)
    {
        $answer = $this->pdo->prepare('SELECT id, date_end, status, book_isbn, lib_name FROM reservation WHERE user_id =?;');
        $answer->execute(array($id));
        return $answer;
    }

    // function that is called almost every time and it updates status of reservation which runs out of time
    function auto_update_reservations()
    {
        $this->pdo->query('UPDATE reservation SET date_end=null, status=3 WHERE status=1 and current_date() > date_end;');
        $this->pdo->query('UPDATE reservation SET status=4 WHERE status=2 and current_date() > date_end;');
        return;
    }

    // function taht creates new reservation
    function add_reservation($isbn, $lib_name, $id)
    {
        $answer = $this->pdo->prepare('INSERT INTO reservation(date_end, status, book_isbn, lib_name, user_id) VALUES( DATE_ADD(current_date(), INTERVAL 7 day),1, ?, ?, ?);
        ');
        $answer->execute(array($isbn, $lib_name, $id));
        return;
    }

    // function that checks if user voted for specific book in library
    function user_vote($id, $isbn, $lib)
    {
        $answer = $this->pdo->prepare('SELECT COUNT(1) as count FROM votes WHERE user_id =? and book_isbn=? and lib_name=?;');
        $answer->execute(array($id, $isbn, $lib));
        return $answer->fetch();
    }

     // function that add vote to database
     function add_vote($id, $isbn, $lib)
     {
         $answer = $this->pdo->prepare('INSERT INTO votes (book_isbn, lib_name, user_id) VALUES (?,?,?)');
         $answer->execute(array($isbn, $lib, $id));
         return;
     }

    function get_book_by_isbn($isbn)
    {
        $answer = $this->pdo->prepare('SELECT name FROM book WHERE isbn=?');
        $answer->execute(array($isbn));
        return $answer->fetch();
    }

    function add_user($data)
    {
        $stmt = $this->pdo->prepare('INSERT INTO address (street, number, city, postal_code) VALUES (?, ?, ?, ?)');
        
        if ($stmt->execute([$data['street'], $data['number'], $data['city'], $data['postal_code']]))
        {
            $data['address_id'] = $this->pdo->lastInsertId();
            unset($stmt);
            $pwd = password_hash($data['password'], PASSWORD_DEFAULT);
            $role = 1;
            $stmt = $this->pdo->prepare('INSERT INTO user (name, surname, mail, phone, password, role, address_id) VALUES (?, ?, ?, ?, ?, ?, ?)');
            if ($stmt->execute([$data['name'], $data['surname'], $data['mail'], $data['phone'], $pwd, $role, $data['address_id']]))
            {
                $data['user_id'] = $this->pdo->lastInsertId();
                return $data;
            }

            return;
        }
        else
        {
            return FALSE;
        }
    }

    //function return true if user with given mail is in databse
    function mail_exist($mail){
        $answer = $this->pdo->prepare('SELECT mail FROM user WHERE mail=?');
        $answer->execute(array($mail));
        if($answer->rowCount() > 0){
            return TRUE;
        }
        else {
            return FALSE;
        }
    }

    function book_exist($isbn){
        $answer = $this->pdo->prepare('SELECT isbn FROM book WHERE isbn=?');
        $answer->execute(array($isbn));
        if($answer->rowCount() > 0){
            return TRUE;
        }
        else {
            return FALSE;
        }
    }

    function add_book($data){
        $stmt = $this->pdo->prepare("INSERT INTO book(isbn, name, authors, year, publisher, genre, rating) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([$data['isbn'], $data['name'], $data['authors'], $data['year'], $data['publisher'], $data['genre'], $data['rating']]);
    }
}

?>