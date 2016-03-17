<?php
	
	require("../db/MySQLDAO.php");
	require("../db/Conn.php");
	
	$returnValue = array();
	
	if(empty($_REQUEST["userEmail"]) || empty($_REQUEST["userPassword"])
			|| empty($_REQUEST["userFirstName"])
			|| empty($_REQUEST["userLastName"]))
	{
		$returnValue["status"]="400";
		$returnValue["message"]="Missing required information";
		echo json_encode($returnValue);
		return;
	}
	
	//html entities protects against SQL injections
	$userEmail = htmlentities($_REQUEST["userEmail"]);
	$userPassword = htmlentities($_REQUEST["userPassword"]);
	$userFirstName = htmlentities($_REQUEST["userFirstName"]);
	$userLastName = htmlentities($_REQUEST["userLastName"]);
	
	//Generate secure password
	//sha1 calcualtes the sha1 of a string
	$salt = openssl_random_pseudo_bytes(16);
	//generate random psuedo bytes and concatenate to userpassword
	//and then sha1 generates a secured hash string
	$secured_password = sha1($userPassword . $salt);
	
	//connect to database
	//database info is included in Conn php file, not in this php file for extra security
	$dao = new MySQLDAO(Conn::$dbhost, Conn::$dbuser, Conn::$dbpass, Conn::$dbname);
	$dao->openConnection();

?>