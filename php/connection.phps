<?php
	define ('DB_HOST', 'localhost');
	define ('DB_USER', 'root');
	define ('DB_PASSWORD', '');
	define ('DB_NAME', 'testP');

	$link = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

	if (mysqli_connect_error()) {
		die ("Could not connect to database");
	}

?>