<?php

// getting requires
require_once 'DbOperation.php';

$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
  if (!verifyRequiredParams(array('username', 'firstname', 'lastname', 'email', 'password'))) {
    // getting values
    $username = $_POST['username'];
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];
    $email = $_POST['email'];
    $password = $_POST['password'];

    // create db operation object
    $db = new DbOperation();

    $to = $email;
    $subject = 'Welcome!';
    $txt = "Thank you for joining CODA!";
    $headers = "From: coda.dev.uvm@gmail.com";

    if (verifyEmail($email)) {
      // add user to database
      $result = $db->createUser($username, $firstname, $lastname, $email, $password);
    } elseif (!verifyEmail($email)) {
      $response['error'] = true;
      $response['message'] = 'Your email is invalid';
      echo 'Invalid email';
    }

    // making response accordingly
    if ($result == USER_CREATED && verifyEmail($email)) {
      $response['error'] = false;
      $response['message'] = 'User created';
      echo 'User created' . PHP_EOL;
      mail($to,$subject,$txt,$headers);
      // $mailed = sendMail($to, $cc, $bcc, $from, $subject, $message);
    } elseif ($result == USER_ALREADY_EXIST) {
      $response['error'] = true;
      $response['message'] = 'User already exists';
      echo 'User already exists' . PHP_EOL;
    } elseif (!verifyEmail($email)) {
      $response['error'] = true;
      $response['message'] = 'Your email is invalid';
      echo 'Invalid email' . PHP_EOL;
    } elseif ($result == USER_NOT_CREATED) {
      $response['error'] = true;
      $response['message'] = 'User was not created';
      echo 'User not created' . PHP_EOL;
    }
  } else {
    $response['error'] = true;
    $response['message'] = 'Required params are missing';
  }
} else {
  $response['error'] = true;
  $response['message'] = 'Invalid request';
}

function verifyEmail($testString) {
    // Check for a valid email address
    // see: http://www.php.net/manual/en/filter.examples.validation.php
    return filter_var($testString, FILTER_VALIDATE_EMAIL);
}

// This function mails the text passed in to the people specified
// it requires the person sending it to and a message
// CONSTRAINTS:
//      $to must not be empty
//      $to must be an email format
//      $cc must be an email format if its not empty
//      $bcc must be an email format if its not empty
//      $from must not be empty
//      $subject must not be empty
//      $message must not be empty
//      $message must have a minimum number of characters
//      $message must be a minuim length (just count the characters and spaces
//
//      $from should be cleaned of invalid html before being sent here but needs
//            to allow < and >
//      $message should be cleaned of invalid html before being sent here as you
//            may want to allow html characters
//
// function returns a boolean value
function sendMail($to, $cc, $bcc, $from, $subject, $message) {
    $MIN_MESSAGE_LENGTH = 40;

    $blnMail = false;

    $to = filter_var($to, FILTER_SANITIZE_EMAIL);
    $cc = filter_var($cc, FILTER_SANITIZE_EMAIL);
    $bcc = filter_var($bcc, FILTER_SANITIZE_EMAIL);

    $subject = htmlentities($subject, ENT_QUOTES, "UTF-8");

    // just checking to make sure the values passed in are reasonable
    if (empty($to))
        return false;
    if (!filter_var($to, FILTER_VALIDATE_EMAIL))
        return false;

    if ($cc != "")
        if (!filter_var($cc, FILTER_VALIDATE_EMAIL))
            return false;

    if ($bcc != "")
        if (!filter_var($bcc, FILTER_VALIDATE_EMAIL))
            return false;

    if (empty($from))
        return false;

    if (empty($subject))
        return false;

    if (empty($message))
        return false;
    if (strlen($message) < $MIN_MESSAGE_LENGTH)
        return false;

    /* message */
    $messageTop = '<html><head><title>' . $subject . '</title></head><body>';
    $mailMessage = $messageTop . $message;
    $headers = "MIME-Version: 1.0\r\n";
    $headers .= "Content-type: text/html; charset=utf-8\r\n";
    $headers .= "From: " . $from . "\r\n";
    if ($cc != "")
        $headers .= "CC: " . $cc . "\r\n";
    if ($bcc != "")
        $headers .= "Bcc: " . $bcc . "\r\n";
    /* this line actually sends the email */
    $blnMail = mail($to, $subject, $mailMessage, $headers);

    return $blnMail;
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
