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

    function get_filtered_books($select)
    {
        $answer = $this->pdo->query($select);
        return $answer;
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
            //$this->lastError = $stmt->errorInfo();
            return FALSE;
        }
    }
}

?>