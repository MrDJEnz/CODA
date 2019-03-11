<?php
session_start();
include "top.php";
echo $_SESSION["hashedPass"]
?>

<?php
// echo $_SESSION["activeUser"];
// echo $_SESSION["hashedPass"];
//echo $_SESSION["hashedPass"];
include ('styleIndex.php');
$data = array();
?>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<html>
<head>
	<title>View Records</title>
</head>
<body>
	<table>
		<?php
		$query = 'SELECT pmkID, flduserName, fldhashedPass, flddate, flddoctorName, flddetails FROM tblUserAppointments  WHERE flduserName = ? AND fldhashedPass = ? ORDER BY flddate ASC';
		$data[] = $_SESSION["activeUserEmail"];
		$data[] = $_SESSION["hashedPass"];
		$records = $thisDatabaseReader->select($query, $data, 1, 2, 0, 0, false, false);

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
 -->			<a href="deleteApp.php?id=<?php echo $record["pmkID"]; ?>">Edit</a></td>

		</td>
		<td align="center">
<!-- 			<td align="center"><?php echo $id; ?></td>
 -->			<a href="deleteApp.php?id=<?php echo $record["pmkID"]; ?>">Delete</a></td>

		</td>
	</tr>
	<?php $count++; } ?>
</table>
</body>
</html>