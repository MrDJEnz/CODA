<?php
session_start();
include "top.php";
//$_SESSION["login"] = false;
//$_SESSION["activeUser"] = "null";
$_SESSION["hashedPass"] = "null";
$_SESSION["activeUserEmail"] = "null";

?>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous"> 

<?php
include ('styleIndex.php')
?>
<title>Hello, world!</title>
<body>
	<script>

	</script>
<!-- 	<?php
	include ('styleIndex.php')
	?> -->
	<header>
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
						<li class="nav-item active">
							<a class="nav-link" href="#">Home
								<span class="sr-only">(current)</span>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="/cs295_CODA/Web/register.php">Register</a>
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
		
		<!-- Navbar -->
		<!-- Full Page Intro -->
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
						<?php
						echo ($_SESSION["activeUser"]);
						if ($_SESSION["activeUser"] == "null"){
							?>
							
							<?php }?>
							<!--Grid column-->
						</div>
						<!--Grid row-->
					</div>
					<!-- Content -->
				</div>
				<!-- Mask & flexbox options-->
			</div>
			<!-- Full Page Intro -->
		</header>
		<!-- Main navigation -->

	</body>
	</html>