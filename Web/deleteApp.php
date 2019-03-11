<?php
session_start();
?>
<?php
include "top.php";

$id=$_REQUEST['id'];
$query = "DELETE FROM tblUserAppointments WHERE pmkID = ?"; 
$thisDatabaseAdmin->delete($query, $id, 1, 0, 0, 0);
//echo  "<h2>Record Deleted. Feel Free to Delete Another!</h2>";;
header("Location: viewApp.php");
?>