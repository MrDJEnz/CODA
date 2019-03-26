<?php

class DbOperation {

  private $conn;

  // Constructor
  function __construct() {
    require_once dirname(__FILE__) . '/constants.php';
    require_once dirname(__FILE__) . '/DbConnect.php';

    // open db connection
    $db = new DbConnect();
    $this->conn = $db->connect();
  }

  public function userLogin($username, $pass) {
        $password = md5($pass);
        $stmt = $this->conn->prepare("SELECT fldUsername FROM tblUsers WHERE fldUsername = ? AND fldPassword = ?");
        $stmt->bind_param("ss", $username, $password);
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }

    /*
     * After the successful login we will call this method
     * this method will return the user data in an array
     * */

    public function getUserByUsername($username) {
        $stmt = $this->conn->prepare("SELECT fldUsername, fldEmail FROM tblUsers WHERE fldUsername = ?");
        $stmt->bind_param("s", $username);
        $stmt->execute();
        $stmt->bind_result($uname, $email);
        $stmt->fetch();
        $user = array();
        $user['username'] = $uname;
        $user['email'] = $email;
        return $user;
    }

  // Create user function
  public function createUser($username, $email, $pass) {
    if (!$this->isUserExist($username, $email)) {
      $password = md5($pass);
      $stmt = $this->conn->prepare('INSERT INTO tblUsers (fldUsername, fldEmail, fldPassword) VALUES (?, ?, ?)');
      $stmt->bind_param('sssss', $username, $email, $password);
      if ($stmt->execute()) {
        return USER_CREATED;
      } else {
        return USER_NOT_CREATED;
      }
    } else {
      return USER_ALREADY_EXIST;
    }
  }

  private function isUserExist($username, $email) {
    $stmt = $this->conn->prepare('SELECT fldUsername FROM tblUsers WHERE fldUsername = ? OR fldEmail = ?');
    $stmt->bind_param('sss', $username, $email);
    $stmt->execute();
    $stmt->store_result();
    return $stmt->num_rows > 0;
  }
}
?>
