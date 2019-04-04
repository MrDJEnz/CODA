<?php
session_start();
include "top.php";
//echo $_SESSION["hashedPass"]
?>

<?php
// echo $_SESSION["activeUser"];
// echo $_SESSION["hashedPass"];
//echo $_SESSION["hashedPass"];
$data = array();
?>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<?php
include ('styleIndex.php');
?>
<html>
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
<head>
<title>View Records</title>
<div class="view" style="background-image: linear-gradient(to right, #789cca, #5374a7, #3e67a1); background-repeat: no-repeat; background-size: cover; background-position: center center;">
<!-- Mask & flexbox options-->
<div class="mask rgba-gradient d-flex justify-content-center align-items-center">
	<div class="container">
  <!--Grid row-->
  <div class="row mt-5">
<div class="col-md-6 col-xl-5 mb-4">
</head>
<body>
<table>
	<?php
	$query = 'SELECT pmkID, flduserName, fldhashedPass, flddate, flddoctorName, flddetails FROM tblUserAppointments  WHERE flduserName = ? AND fldhashedPass = ? ORDER BY flddate ASC';
	$data[] = $_SESSION["activeUserEmail"];
	$data[] = $_SESSION["hashedPass"];
	$records = $thisDatabaseReader->select($query, $data, 1, 2, 0, 0, false, false);
	$AppCount = 0;
	foreach ($records as $record){
		$AppCount++;
		}
		if ($AppCount == 0){
			print '<h1>' ;
			echo("No Appointments Scheduled! Please try again later");
			print '</h1>';

				}else{
			print '<tr>';
			print '<th>' . "Date" . '</th>';
			print '<th>' . "Doctor's Name" . '</th>';
			print '<th>' . "Details" . '</th>';
			print '<th>' . "Edit" . '</th>';
			print '<th>' . "Delete" . '</th>';

			print '</tr>';
			foreach ($records as $record) {
				$id = $record['pmkID'];
				$dateData = $record['flddate'];
				$docData = $record['flddoctorName'];
				$detailData = $record['flddetails'];
	/*foreach ($records as $record) {
		$dateData = $record['flddate'];
		$docData = $record['flddoctorName'];
		$detailData = $record['flddetails'];
		print '<tr>';
		print '<td>' . $dateData . '</td>';
		print '<td>' . $docData . '</td>';
		print '<td>' . $detailData . '</td>';
		print '</tr>';
	}
	?>
*/

	?>
	
	<td align="center"><?php echo $dateData; ?></td>
	<td align="center"><?php echo $docData; ?></td>
	<td align="center"><?php echo $detailData; ?></td>
	<td align="center">
	</td>
	<td align="center">
<!-- 			<td align="center"><?php echo $id; ?></td>
-->			<a href="editApp.php?id=<?php echo $record["pmkID"]; ?>">Edit</a></td>

</td>
<td align="center">
<!-- 			<td align="center"><?php echo $id; ?></td>
-->			<a href="deleteApp.php?id=<?php echo $record["pmkID"]; ?>">Delete</a></td>

</td>
</tr>
</div>
	</div>
			</div>
		</div>

	</div>
<?php } ?>
<?php $count++; } ?>
<?php }?>
</table>
</body>
</html>