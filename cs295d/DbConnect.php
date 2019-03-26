<?php
class DbConnect {

  private $conn;

  function __construct() {
  }

  // Make DB connection
  function connect() {
    require_once 'constants.php';

    // Connect to MySQL database
    $this->conn = new mysqli(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME);

    // Check for connection error
    if (mysqli_connect_errno()) {
      print 'Failed to connect to MySQL: ' . mysqli_connect_error();
    }

    // returning connection var
    return $this->conn;
  }
}
?>
