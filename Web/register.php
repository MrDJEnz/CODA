<?php
session_start();
include "top.php";
$_SESSION["registered"] = FALSE;
?>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous"> 
 <?php
 include ('styleIndex.php')
?> 
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
          <a class="nav-link" href="/cs295_CODA/Web/index.php">Home</a>
        </li>
<li class="nav-item">
          <a class="nav-link" href="#">Register</a>
          <span class="sr-only">(current)</span>
        </li>
       <li class="nav-item">
              <a class="nav-link" href="/cs295_CODA/Web/login.php">Login</a>
            </li>
        
        
        <li class="nav-item">
          <a class="nav-link" href="/cs295_CODA/Web/logout.php">Logout</a>
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
              <div class="col-md-6 col-xl-5 mb-4">
                <form id = "Register" method= "post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
                  <!--Form-->
                  <div class="card wow fadeInRight" data-wow-delay="0.3s">
                    <div class="card-body">
                      <!--Header-->
                      <div class="text-center">
                        <h3 class="white-text">
                          <i class="fa fa-user white-text"></i> Register:</h3>
                          <hr class="hr-light">
                        </div>
                        <!--Body-->
                        <div class="md-form">
                          <i class="fa fa-user prefix white-text active"></i>
                          <input type="text" name = "nameField" id="nameField" class="white-text form-control">
                          <label for="nameField" class="active">Your name</label>
                        </div>
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
                          <button class="btn btn-indigo" name = "buttonSignUp" id="buttonSignUp">Sign up</button>
                          <div class="text-center mt-4">
                            <hr class="hr-light mb-3 mt-4">
                            <div class="inline-ul text-center d-flex justify-content-center">
                              <a class="p-2 m-2 tw-ic">
                                <i class="fa fa-twitter white-text"></i>
                              </a>
                              <a class="p-2 m-2 li-ic">
                                <i class="fa fa-linkedin white-text"> </i>
                              </a>
                              <a class="p-2 m-2 ins-ic">
                                <i class="fa fa-instagram white-text"> </i>
                              </a>
                            </div>
                            <hr class="hr-light mb-3 mt-4">
                            <div class="inline-ul text-center d-flex justify-content-center">
                              <?php if (isset($_POST['buttonSignUp'])){?>
                                <?php $newUserdata = array()?>
                                <?php $nameValue = htmlspecialchars($_POST['nameField'])?>
                                <?php $emailValue = htmlspecialchars($_POST['emailField'])?>
                                <?php $emailValue = strtolower($emailValue) ?>
                                <?php $passValue = htmlspecialchars($_POST['passwordField'])?>

                                <?php $passHashed = hash('sha256',$passValue) ?>

                                <?php $query = 'INSERT INTO tblUsers SET '?>
                                <?php $query .= 'fldUsername = ?, '?>
                                <?php $query .= 'fldEmail = ?, '?>
                                <?php    $query .= 'fldPassword = ?'?>

                                <?php $newUserdata[] = $nameValue ?>
                                <?php $newUserdata[] = $emailValue ?>
                                <?php $newUserdata[] = $passHashed ?>
                                <?php if ($nameValue != "" AND $emailValue != "" AND $emailValue != ""){$records = $thisDatabaseWriter->insert($query, $newUserdata, 0, 0, 0, 0, false, false)?>
                                  <h1>Congrats, your registration has been confirmed! Thank you!!</h1>
 
                             <?php  $_SESSION["registered"] = TRUE; ?> 
                             <?php $_SESSION["registeredemail"] = $emailValue; ?>
                             <?php $_SESSION["registeredpass"] = $passValue; ?>
                              
                              <script type="text/javascript">
window.location = "login.php";
</script>
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