<?php
session_start();
?>
<?php
include "top.php";
$data = array();
$id=$_REQUEST['id'];
$data[]= $id;
$query = "DELETE FROM tblUserAppointments WHERE pmkID = ?"; 
$thisDatabaseAdmin->delete($query, $data, 1, 0, 0, 0);
//echo  "<h2>Record Deleted. Feel Free to Delete Another!</h2>";;
header("Location: viewApp.php");
?>