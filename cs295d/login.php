<?php

require_once 'DbOperation.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  // checks if variables were set or not
    if (isset($_POST['username']) && isset($_POST['password'])) {

      // create db operation object
        $db = new DbOperation();

        // making response accordingly
        if ($db->userLogin($_POST['username'], $_POST['password'])) {
            $response['error'] = false;
            $response['user'] = $db->getFirstNameByUsername($_POST['username']);
            $response['message'] = 'Login Successful';
            echo 'Login Successful' . PHP_EOL;
        } else {
            $response['error'] = true;
            $response['message'] = 'Invalid username or password';
            echo 'Invalid Username or Password' . PHP_EOL;
        }

    } else {
        $response['error'] = true;
        $response['message'] = 'Parameters are missing';
    }

} else {
    $response['error'] = true;
    $response['message'] = "Request not allowed";
}

echo json_encode($response);
?>
