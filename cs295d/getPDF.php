<?php
session_start();

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
      header('Cache-Control: public');
      header('Content-type: application/pdf');
      header('Content-Disposition: inline; filename='.$_SESSION["pdfname"].'');
      echo '<!DOCTYPE html>';
      echo '<html>';
      echo '<head>';
      echo '<meta http-equiv="Content-Type" content="text/html; charset=utf-8">';
      echo '<title>Embeded PDF</title>';
      echo '</head>';
      echo '<body>';
      echo '<iframe data="data:application/pdf;base64,' . $_SESSION["pdf"] . '" type="application/pdf" style="height:1200px;width:100%"></iframe>';
      echo '</body>';
      echo '</html>';
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
?>
