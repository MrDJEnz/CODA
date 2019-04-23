<?php
session_start();

class DbOperation {

  private $conn;
  // $pdf = "";

  // Constructor
  function __construct() {
    require_once 'constants.php';
    require_once 'DbConnect.php';

    // open db connection
    $db = new DbConnect();
    $this->conn = $db->connect();
  }

  // function for user login
  // using sha256 hashing to verify password user entered
  // matches the encrypted password on the database
  // SQL statement checks the username on the table of users
  // and sees if the username exists by seeing if the statement
  // returns more than one row
  public function userLogin($username, $pass) {
    $sql = $this->conn->prepare("SELECT fldCurrentTime FROM tblUsers WHERE fldUsername = ?");
    $sql->bind_param("s", $username);
    if($sql->execute()) {
      $result = $sql->get_result();
      while ($row = $result->fetch_assoc()) {
        $currentTime = $row['fldCurrentTime'];
      }
    }
    //$combinedPassword = $username + $pass;
    $combinedPassword = $username + $pass + $currentTime;
    $password = hash("sha256", $combinedPassword);
    $stmt = $this->conn->prepare("SELECT fldFirstName FROM tblUsers WHERE fldUsername = ? AND fldPassword = ?");
    $stmt->bind_param("ss", $username, $password);
    if($stmt->execute()) {
      $res = $stmt->get_result();
      while ($row2 = $res->fetch_assoc()) {
        $firstName = $row2['fldFirstName'];
      }
    }
    // $stmt->store_result();
    // return $stmt->num_rows > 0;
    return $firstName;
  }

    /*
     * After the successful login we will call this method
     * this method will return the user data in an array
     * */
    public function getFirstNameByUsername($username) {
        $stmt = $this->conn->prepare("SELECT fldFirstName FROM tblUsers WHERE fldUsername = ?");
        $stmt->bind_param("s", $username);
        if($stmt->execute()) {
          $res = $stmt->get_result();
          while ($row = $res->fetch_assoc()) {
            $firstName = $row['fldFirstName'];
          }
        }
        $stmt->fetch();
        $user = array();
        $user['firstName'] = $firstName;
        return $user;
    }

  // Create user function
  // first checks if the email exists or not
  // if not, hash the user's password and
  // insert username, email and hashed password
  // into the database
  // if this was successful, then send proper return message
  // if not, then send proper return message
  // lastly, if user existed in the first place, send the proper return message
  public function createUser($username, $firstname, $lastname, $email, $pass) {
    if (!$this->isUserExist($username)) {
        //$combinedPassword = $username + $pass;
      $stmt = $this->conn->prepare("INSERT INTO tblUsers (fldUsername, fldFirstName, fldLastName, fldEmail) VALUES (?, ?, ?, ?)");
      $stmt->bind_param("ssss", $username, $firstname, $lastname, $email);
      if ($stmt->execute()) {
        $sql = $this->conn->prepare("SELECT fldCurrentTime FROM tblUsers WHERE fldUsername = ?");
        $sql->bind_param("s", $username);
        if($sql->execute()) {
          $res = $sql->get_result();
          while ($row = $res->fetch_assoc()) {
            $currentTime = $row['fldCurrentTime'];
          }
        }
          $combinedPassword = $username.$pass.$currentTime;
        $password = hash("sha256", $combinedPassword);
        $sql2 = $this->conn->prepare("UPDATE tblUsers SET fldPassword = BINARY '$password' WHERE fldUsername = ?");
        $sql2->bind_param("s", $username);
        $sql2->execute();
        return USER_CREATED;
      } else {
        return USER_NOT_CREATED;
      }
    } else {
      return USER_ALREADY_EXIST;
    }
  }

  // function that checks if the username existed already
  // SQL statement checks the table of users to see if the given email
  // combo returns anything, if this number is greater than 0, then there
  // was an username with inputted username already existing up in the database
  private function isUserExist($username) {
    $stmt = $this->conn->prepare("SELECT fldUsername FROM tblUsers WHERE fldUsername = ?");
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $stmt->store_result();
    return $stmt->num_rows > 0;
  }

  // function that will get the correct PDF based on the username
  // SQL statement checks the table of PDFS if the given username
  // matches a username from the table of users and if so, pulls
  // the respective PDF
  public function getPDF($username) {
    try {
      $stmt = $this->conn->prepare("SELECT fldPDFName, fldPDF FROM tblPDFs JOIN tblUsers ON tblPDFs.fldUsername = tblUsers.fldUsername WHERE tblPDFs.fldUsername = ?");
      $stmt->bind_param("s", $username);
      if ($stmt->execute()) {
        $result = $stmt->get_result();
        while ($row = $result->fetch_assoc()) {
          // do something with $row
          // echo $row['fldPDFName'];
          // global $pdf;
          // ob_clean();
          // flush();
          $pdfname = $row['fldPDFName'];
          $_SESSION["pdfname"] = $pdfname;
          $pdf = $row['fldPDF'];
          // $pdf = base64_encode($row['fldPDF']);
          $_SESSION["pdf"] = $pdf;
          // echo $_SESSION["pdf"];
          // echo $pdf;

        //
        //   // Display PDF
        }
        return PDF_FOUND;
      } else {
        return NO_PDF;
      }
    } catch(Exception $e) {
      echo "caught exception: ", $e->getMessage(), "\n";
    }
  }
}
?>
