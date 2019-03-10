<?php
session_start();
include "top.php";

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
	<object data="http://snguon.w3.uvm.edu/cs275/discharge_instructions.pdf" type="application/pdf" width="100%" height="1000">
<a href="http://snguon.w3.uvm.edu/cs275/discharge_instructions.pdf">test.pdf</a>
<?php }?>



<div class="view" style="background-image: linear-gradient(to right, #789cca, #5374a7, #3e67a1); background-repeat: no-repeat; background-size: cover; background-position: center center;">
</object>
</body>
</html>