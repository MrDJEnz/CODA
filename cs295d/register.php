<?php

// getting requires
require_once 'DbOperation.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  if (!verifyRequiredParams(array('username', 'email', 'password'))) {
    // getting values
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    // create db operation object
    $db = new DbOperation();

    // add user to database
    $result = $db->createUser($username, $email, $password);

    // making response accordingly
    if ($result == USER_CREATED) {
      $response['error'] = false;
      $response['message'] = 'User created';
    } elseif ($result == USER_ALREADY_EXIST) {
      $response['error'] = true;
      $response['message'] = 'User already exists';
    } elseif ($result == USER_NOT_CREATED) {
      $response['error'] = true;
      $response['message'] = 'Error occurred';
    }
  } else {
    $response['error'] = true;
    $response['message'] = 'Required params are missing';
  }
} else {
  $response['error'] = true;
  $response['message'] = 'Invalid request';
}

// validate required param in request
function verifyRequiredParams($required_fields) {
  // Getting the request params
  $request_params = $_REQUEST;

  // loop through all params
  foreach ($required_fields as $field) {
    // if any required param is missing
    if (!isset($request_params[$field]) || strlen(trim($request_params[$field])) <= 0) {
      return true;
    }
  }
  return false;
}

echo json_encode($response);
?>
