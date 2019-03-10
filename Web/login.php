<?php
session_start();
include "top.php";
$_SESSION["login"] = false;
$_SESSION["activeUser"] = "null"
?>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<?php
  include ('styleIndex.php')
  ?>
  <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top scrolling-navbar">
      <div class="container">
        <a class="navbar-brand" href="#">
          <strong>C.O.D.A</strong>
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-7" aria-controls="navbarSupportedContent-7" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent-7">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item">
              <a class="nav-link" href="/cs275_CODA/index.php">Home</a>
            </li>

            <li class="nav-item active">
              <a class="nav-link" href="#">Login
                <span class="sr-only">(current)</span>
              </a>
            </li>
            
            <li class="nav-item">
              <a class="nav-link" href="/cs275_CODA/logout.php">Logout</a>
            </li>
          </ul>
          <form class="form-inline">
            <div class="md-form my-0">
              <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
            </div>
          </form>
        </div>
      </div>
    </nav>

<title>Login</title>
<div class="view" style="background-image: linear-gradient(to right, #789cca, #5374a7, #3e67a1); background-repeat: no-repeat; background-size: cover; background-position: center center;">
      <!-- Mask & flexbox options-->
      <div class="mask rgba-gradient d-flex justify-content-center align-items-center">
        <!-- Content -->
        <div class="container">
          <!--Grid row-->
          <div class="row mt-5">
            <!--Grid column-->
            <div class="col-md-6 mb-5 mt-md-0 mt-5 white-text text-center text-md-left">
              <h1 class="h1-responsive font-weight-bold wow fadeInLeft" data-wow-delay="0.3s">Welcome to the CODA Site </h1>
              <hr class="hr-light wow fadeInLeft" data-wow-delay="0.3s">
              <h6 class="mb-3 wow fadeInLeft" data-wow-delay="0.3s">The Coda project was designed and developed by a team of 3 medical students in coordination with 5 Computer Science majors. The project has initially been developed for a final project in CS 275 (Mobile Apps) during the Fall 2018 semester.

              If you are new, please register on the right. If you are a returning user please locate the signin button.</h6>
            </div>
<div class="col-md-6 col-xl-5 mb-4">
  <form id = "Login" method= "post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
    <!--Form-->
    <div class="card wow fadeInRight" data-wow-delay="0.3s">
      <div class="card-body">
        <!--Header-->

        <div class="text-center">
          <h3 class="white-text">
            <i class="fa fa-user white-text"></i> Login:</h3>
            <hr class="hr-light">
          </div>
          <!--Body-->
          <div class="md-form">
            <i class="fa fa-envelope prefix white-text active"></i>
            <input type="email" id="emailField" name = "emailField" class="white-text form-control">
            <label for="emailField" class="active">Your email</label>
          </div>
          <div class="md-form">
            <i class="fa fa-lock prefix white-text active"></i>
            <input type="password" name = "passwordField" id="passwordField" class="white-text form-control">
            <label for="passwordField">Your password</label>
          </div>
          <div class="text-center mt-4">
            <button class="btn btn-indigo" name = "buttonLogin" id="buttonLogin">Login</button>
            <hr class="hr-light mb-3 mt-4">
            <div class="inline-ul text-center d-flex justify-content-center">
              <?php if (isset($_POST['buttonLogin'])){?>
                <?php $whereCount = 1; ?>
                <?php $conditionscount=0; ?>
                <?php $quotescount=0; ?>
                <?php $symbolcount=0;?>
                <?php $whereClause = "";?>
                <?php $query = 'SELECT fldUsername, fldEmail, fldPassword FROM tblUsers WHERE fldEmail = ?'?>
                <?php $enteredUserdata = array()?>
                <?php $emailValue = htmlspecialchars($_POST['emailField'])?>
                <?php $passValueNEW = htmlspecialchars($_POST['passwordField'])?>

                <?php $newpassHashed = password_hash($passValueNEW,PASSWORD_DEFAULT) ?>
                <?php $verifyTest =  password_verify ($passValue, $passHashed)?>
                <?php $enteredUserdata[] = $emailValue ?>
                <?php if ($emailValue != "" AND $emailValue != ""){$records = $thisDatabaseReader->select($query, $enteredUserdata, $whereCount, $conditionscount, $quotescount, $symbolcount, false, false);?>
                  <?php foreach ($records as $record) {
                    $dbHash = ((string)$record['fldPassword']);
                    $loginUser = ((string)$record['fldUsername']);}?>

                  
                  <?php if (password_verify($passValueNEW,$dbHash)) {
                    ?>
                    <h1> Password is valid! Logging in... you will be directed to the main page. Thank you!</h1>
                  <?php echo $loginUser ?>
                  <?php $_SESSION["login"] = true?>
                   <a href="/cs275_CODA/privatePage1.php">Click here</a>
                   <?php $_SESSION["activeUser"] = $loginUser?>


                  <?php }else {
                    echo 'Invalid password' ."<br>";}?>
                  <?php }?>
                <?php }?>
              </a>
            </div>
          </div>
        </div>

      </div>
    </form>

    <!--/.Form-->

        </div>
            <!--Grid row-->
          </div>
          <!-- Content -->
        </div>
        <!-- Mask & flexbox options-->
      </div>
      <!-- Full Page Intro -->
      </main>
    <!--Main Layout-->

  </body>
  </html>
 