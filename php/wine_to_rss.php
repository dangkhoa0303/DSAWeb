<?php
	header("Content-Type: application/rss+xml; charset=ISO-8859-1");

	include "connection.php";

	$rssfeed = '<?xml version="1.0" encoding="utf-8"?>';
	$rssfeed .= '<rss version="2.0">';
	$rssfeed .= '<channel>';
	$rssfeed .= '<title>Wine RSS feed</title>';
	$rssfeed .= '<link>http://localhost/DSA_Assignment/index.php</link>';
	$rssfeed .= '<description>Wine to RSS Assignment</description>';
	$rssfeed .= '<copyright>Copyright (C) DSA Coursework DangKhoa</copyright>';

	$query = "SELECT Name, Image, Description FROM Wine";

	$result = mysqli_query($link, $query);

	if ($result) {

		while ($row = mysqli_fetch_array($result)) {
			extract($row);

			$rssfeed .= '<item>';
			$rssfeed .= '<title>' . $Name . '</title>';
			$rssfeed .= '<link>' . $Image . '</link>';
			$rssfeed .= '<description>' . $Description . '</description>';
			$rssfeed .= '</item>';
		}

		$rssfeed .= '</channel>';
		$rssfeed .= '</rss>';

		echo $rssfeed;

	} else {
		die ("Could not query");
	}
?>