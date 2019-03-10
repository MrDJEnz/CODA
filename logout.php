<?php
session_start();
include "top.php";
?>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

<title>Hello, world!</title>
<body>
	<script>

	</script>
	<?php
	include ('styleIndex.php')
	?>
	<header>
		<!-- Navbar -->
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
							<h6 class="mb-3 wow fadeInLeft" data-wow-delay="0.3s">Thank you for using CODA. Please come back soon!</h6>
						</div>
						<!--Grid column-->
						<!--Grid column-->
								<!--/.Form-->
								<?php
// remove all session variables
session_unset();

// destroy the session
session_destroy();

echo "You have now been logged out! Thank you!!"
?>
							</div>
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
		<!--Main Layout-->
		<main>
			<div class="container">
				<!--Grid row-->
				<div class="row py-5">
					<!--Grid column-->
					<div class="col-md-12 text-center">
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
					</div>
					<!--Grid column-->
				</div>
				<!--Grid row-->
			</div>
		</main>
		<!--Main Layout-->

	</body>
	</html>