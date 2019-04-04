<?php

require_once 'DbOperation.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  // checks if variables were set or not
    if (isset($_POST['username'])) {
      // create db operation object
      $db = new DbOperation();

      // making response accordingly
      if ($db->getPDF($_POST['username']) {

      }
    }




}

echo json_encode($response);
