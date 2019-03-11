<?php
session_start();
include "top.php";
?>
<?php
/*echo $_SESSION["activeUser"];
echo $_SESSION["hashedPass"];
echo $_SESSION["activeUserEmail"];*/

?>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<?php
include ('styleIndex.php')
?>

<!-- <!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert New Record</title>
</head>
<body>
	<h1>Insert New Record</h1>
	<form name="form" method="post" action=""> 
		<p><input type="date" name="date" placeholder="Enter the Appointment Date" required /></p>
		<p><input type="text" name="doc" placeholder="Enter the Doctor's Name" required /></p>
		<p><input type="text" name="details" placeholder="Enter any other Details" /></p>
		<p><input name="submit" type="submit" value="Submit" /></p>
	</form>
</body>
</html> -->


<!-- <body>
	<h1>Log a New Appointment</h1>

  <?php
  echo "Welcome Back, " . $_SESSION["activeUser"]
  ?> -->
  <?php if ($_SESSION["login"] !=  1){
   print ("Must Login First2");
   include ("login.php");
 }
 else{
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
            <a class="nav-link" href="index.php">Home</a>
          </li>

          <li class="nav-item active">
            <a class="nav-link" href="privatePage1.php">View Discharge Papers
            </a>
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
            <li class="nav-item">
            <a class="nav-link" href="/cs295_CODA/Web/logout.php">Logout</a>
          </li>
      </ul>  
        </div>
      </form>
    </div>
  </div>
</nav>

<title>Record a New Appointment</title>
<div class="view" style="background-image: linear-gradient(to right, #789cca, #5374a7, #3e67a1); background-repeat: no-repeat; background-size: cover; background-position: center center;">
  <!-- Mask & flexbox options-->
  <div class="mask rgba-gradient d-flex justify-content-center align-items-center">
  	<div class="container">
      <!--Grid row-->
      <div class="row mt-5">
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
						<input type="date" id="date" name = "date" class="white-text form-control">
						<label for="date" class="active">Appointment Date</label>
					</div>

					<div class="md-form">
						<i class="fa fa-envelope prefix white-text active"></i>
						<input type="text" id="doc" name = "doc" class="white-text form-control">
						<label for="doc" class="active">Doctor Name</label>
					</div>

					<div class="md-form">
						<i class="fa fa-envelope prefix white-text active"></i>
						<input type="text" id="details" name = "details" class="white-text form-control">
						<label for="details" class="active">Details</label>
					</div>

					<div class="text-center mt-4">
						<button class="btn btn-indigo" name = "addAppointment" id="addAppointment">Add Appointment</button>
						<hr class="hr-light mb-3 mt-4">
						<div class="inline-ul text-center d-flex justify-content-center">
							<?php if (isset($_POST['addAppointment'])){?>
								<?php $newUserdata = array()?>
								<?php $date = htmlspecialchars($_POST['date'])?>
								<?php $doc = htmlspecialchars($_POST['doc'])?>
								<?php $details = htmlspecialchars($_POST['details'])?>

								<?php $query = 'INSERT INTO tblUserAppointments SET '?>
								<?php $query .= 'flduserName = ?, '?>
								<?php $query .= 'fldhashedPass = ?, '?>
								<?php    $query .= 'flddate = ?,'?>
								<?php    $query .= 'flddoctorName = ?,'?>
								<?php    $query .= 'flddetails = ?'?>

								<?php $newUserdata[] = $_SESSION["activeUserEmail"] ?>
								<?php $newUserdata[] = $_SESSION["hashedPass"] ?>
								<?php $newUserdata[] = $date ?>
								<?php $newUserdata[] = $doc ?>
								<?php $newUserdata[] = $details ?>
								<?php if ($_SESSION["activeUserEmail"] != "" AND $_SESSION["hashedPass"] != ""){$records = $thisDatabaseWriter->insert($query, $newUserdata, 0, 0, 0, 0, false, false)?>
									<h1>Appointment Saved!</h1>
								<?php }?>
							<?php }?>
						</a>
					</div>
				</div>
			</div>

		</div>
	</form>
	 </div>
            <!--Grid row-->
          </div>
          <!-- Content -->
        </div>
        <!-- Mask & flexbox options-->
      </div>
      <!-- Full Page Intro -->
    </main>
	<?php }?>
<style>

<div class="view" style="background-image: linear-gradient(to right, #789cca, #5374a7, #3e67a1); background-repeat: no-repeat; background-size: cover; background-position: center center;">
</object>
</body>
</html>