<?php
session_start();
include "top.php";
?>=
<?php
include ('styleIndex.php')
?>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

<body>
	<h1>Discharge Instructions</h1>

  <?php
  echo "Welcome Back, " . $_SESSION["activeUser"]
  ?>
  <?php if ($_SESSION["login"] !=  1){
   print ("Must Login First2");
   include ("login.php");
 }
 else{
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
            <a class="nav-link" href="/cs275_CODA/index.php">Home</a>
          </li>

          <li class="nav-item active">
            <a class="nav-link" href="#">View Discharge Papers
            </a>
              <!--  <object data="http://snguon.w3.uvm.edu/cs275/discharge_instructions.pdf" type="application/pdf" width="100%" height="1000">
                <a href="http://snguon.w3.uvm.edu/cs275/discharge_instructions.pdf">test.pdf</a> -->
              </li>
              
              
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                  Appointments
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                  <a class="dropdown-item" href="viewApp.php">View Appointments</a>
                  <a class="dropdown-item" href="newApp.php">Create a New Apppointment</a>
                  <a class="dropdown-item" href="#">Edit an Existing Appointment</a>
                </div>
              </li>
              

<!--           <form class="form-inline">
            <div class="md-form my-0">
              <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
            </div>
          </form> -->
          <li class="nav-item">
            <a class="nav-link" href="/cs275_CODA/logout.php">Logout</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

<?php }?>
<style>

<div class="view" style="background-image: linear-gradient(to right, #789cca, #5374a7, #3e67a1); background-repeat: no-repeat; background-size: cover; background-position: center center;">
</object>
</body>
</html>