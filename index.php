<?php
require "services/component.php";
$db = new MainComponent();
?>

<html>
<head>
        <!-- META TAGS -->
		<meta charset="utf-8">
        
        <!-- TITLE -->
        <title>Knižnica</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="styles/styles.css">
	</head>
    <body>

    <nav class="navbar navbar-expand-lg navbar-light fixed-top" style="position: absolute;">
        <div class="container">
            <a class="navbar-brand" href="#" style="color: white;">Knižnica</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation" style="background-color: white;">
            <span class="navbar-toggler-icon" ></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                <a class="nav-link" href="#" style="color: white; background-color:black; width:100px">Domov</a>
                </li>
                <li class="nav-item">
                <a class="nav-link" href="#" style="color: white; background-color:black; width:100px" >Profil</a>
                </li>
                <li class="nav-item">
                <a class="nav-link" href="#" style="color: white; background-color:black; width:100px">Kontakt</a>
                </li>
                <li class="nav-item">
                <a href="./login/login.php"><button type="button" class="btn btn-primary" style="width:100px">Prihlásiť</button></a>
                </li>
            </ul>
            </div>
        </div>
    </nav>

    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner" style="height: 400px; background-color: rgb(0,0,0); position:relative;">
            <div class="carousel-item active">
            <img class="d-block w-100" src="images/header_images/image3.png" alt="First slide" style="position:absolute;top:60;">
            </div>
            
            <div class="carousel-item"  style="position:absolute;top:60;">
            <img class="d-block w-100" src="images/header_images/image2.png" alt="Second slide">
            </div>

            <div class="carousel-item">
            <img class="d-block w-100" src="images/header_images/image1.png" alt="Third slide">
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

    <?php 
    $genres = $db->get_genres();
    ?>

    <div style="background-color:rgb(200, 217, 219)">
        <div class="container" style="background-color:rgb(200, 217, 219); padding-top:20px">
            <div class="form-row">
                <div class="form-group col-md-12">
                    <h3>Filter</h3>
                    <hr>
                </div>
            </div>
            <form method='get'>
                <div class="form-row">
                    <div class="form-group col-md-3">
                    <label for="inputEmail4">Názov knihy</label>
                    <input type="text" class="form-control" id="inputEmail4" placeholder="Názov knihy" name="nazov">
                    </div>
                    <div class="form-group col-md-3">
                    <label for="inputPassword4">Vydavateľstvo</label>
                    <input type="text" class="form-control" id="inputPassword4" placeholder="Vydavateľstvo" name="vydavatelstvo">
                    </div>
                    <div class="form-group col-md-3">
                    <label for="inputPassword4">Autor</label>
                    <input type="text" class="form-control" id="inputPassword4" placeholder="Autor" name="autor">
                    </div>
                    <div class="form-group col-md-3">
                    <label for="inputState">Žáner</label>
                    <select id="inputState" class="form-control" name="zaner">
                        <option selected>-</option>
                        <?php
                        while($genre = $genres->fetch())
                        {
                            echo "<option>".$genre['genre']."</option>";
                        }
                        ?>
                    </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 text-center">
                        <button type="submit" class="btn btn-primary">Filtrovať</button>
                    </div>
                </div>
            </form>

            <table class="table table-striped table-dark">
                <thead class="thead-dark">
                    <tr>
                    <th scope="col">Kniha</th>
                    <th scope="col">Názov</th>
                    <th scope="col">Autori</th>
                    <th class="hide" scope="col">Žáner</th>
                    <th class="hide" scope="col">Ks</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    // TODO if there is no filter set -> then i have to render all books, otherwise i need to render only those which match filter
                    $books = $db->get_books();
                    while($book = $books->fetch())
                    {
                        echo "<tr>";
                        echo '<td> <img src="images/books/'.$book['isbn'].'.png" style="width:120px"/> </td>';
                        // TODO here will be also href from button to book subpage
                        echo '<td style="vertical-align:middle"><b>'.$book['name'].'</b><br/><button type="button" class="btn btn-primary" style="margin-top:10px">Otvoriť</button></td>';
                        echo '<td style="vertical-align:middle"><b>'.$book['authors'].'</b></td>';
                        echo '<td class="hide" style="vertical-align:middle"><b>'.$book['genre'].'</b></td>';

                        // i need to know how many pieces of each book there are available
                        $count = $db->get_total_sum_of_book($book['isbn']);
                        echo '<td class="hide" style="vertical-align:middle"><b>'.$count['count'].'</b></td>';
                    }
                    ?>
                </tbody>
            </table>
        </div>
    </div>

    

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>