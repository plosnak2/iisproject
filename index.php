<html>
<head>
        <!-- META TAGS -->
		<meta charset="utf-8">
        
        <!-- TITLE -->
        <title>Knižnica</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	</head>
    <body>
    <?php include 'static/navbar.php' ?>

    <div style="background-color:rgb(200, 217, 219)">
        <div class="container" style="background-color:rgb(200, 217, 219); padding-top:20px">
            <div class="form-row">
                <div class="form-group col-md-12">
                    <h3>Filter</h3>
                    <hr>
                </div>
            </div>
            <form>
                <div class="form-row">
                    <div class="form-group col-md-3">
                    <label for="inputEmail4">Názov knihy</label>
                    <input type="email" class="form-control" id="inputEmail4" placeholder="Názov knihy">
                    </div>
                    <div class="form-group col-md-3">
                    <label for="inputPassword4">Vydavateľstvo</label>
                    <input type="password" class="form-control" id="inputPassword4" placeholder="Vydavateľstvo">
                    </div>
                    <div class="form-group col-md-3">
                    <label for="inputPassword4">Autor</label>
                    <input type="password" class="form-control" id="inputPassword4" placeholder="Autor">
                    </div>
                    <div class="form-group col-md-3">
                    <label for="inputState">Žáner</label>
                    <select id="inputState" class="form-control">
                        <option selected>-</option>
                        <option>...</option>
                    </select>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 text-center">
                        <button type="submit" class="btn btn-primary">Filtrovať</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>