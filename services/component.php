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
        $answer = $this->pdo->prepare('SELECT id, mail, password FROM user WHERE mail=?');
        $answer->execute(array($mail));
        return $answer->fetch();
    }
}

?>