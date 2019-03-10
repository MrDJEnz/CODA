<?php
include "lib/constants.php";
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>CS 275 Coda: Web Platform</title>
    <meta charset="utf-8">
    <meta name="author" content="Nicholas R. Lawrence">
    <meta name="description" content="CS 295 Final Project: CODA ('Another Way to Discharge') Web Platform">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">


        <!--[if lt IE 9]>
        <script src="//html5shim.googlecode.com/sin/trunk/html5.js"></script>
    <![endif]-->


    <?php
        // %^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%
        //
        // inlcude all libraries. 
        // %^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%

    print "<!-- require Database.php -->";

    include "lib/constants.php";
    require_once(LIB_PATH . '/Database.php');

        // %^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%^%
        //
        // Set up database connection
        //
        // generally you dont need the admin on the web

    print "<!-- make Database connections -->";
    $dbUserName = get_current_user() . '_reader';
        $whichPass = "r"; //flag for which one to use.
        $dbName = DATABASE_NAME;

        $thisDatabaseReader = new Database($dbUserName, $whichPass, $dbName);

        $dbUserName = get_current_user() . '_writer';
        $whichPass = "w";
        $thisDatabaseWriter = new Database($dbUserName, $whichPass, $dbName);
        ?>	

    </head>
    <script src="http://code.jquery.com/jquery.js"></script>
<script src="bootstrap-4/js/bootstrap.min.js"></script>
<script src="bootstrap-4/js/bootstrap.js"></script>

    <!-- **********************     Body section      ********************** -->
