<?php

require_once 'DbOperation.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  if (!verifyRequiredParams(array('username'))) {
    // getting values
    $username = $_POST['username'];

    // create db operation object
    $db = new DbOperation();

    // find PDF from database
    $result = $db->getPDF($username);

    // making response accordingly
    if ($result == PDF_FOUND) {
      $response['error'] = false;
      $response['message'] = 'PDF found';
    } elseif ($result == NO_PDF) {
      $response['error'] = true;
      $response['message'] = 'No PDF for this username';
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
