<?php

	include "connection.php";

	$WoeID = "";
	$name = "";
	$latitude = "";
	$longitude = "";
	$population = "";
	$description = "";
	$languages = "";
	$climate = "";
	$economy = "";
	$history = "";

	// --------------------------------------------------------------------------------------------
	/* Query data from Country table */

	$query = "SELECT * FROM Country";

	if($result = mysqli_query($link, $query)) {

		while ($row = mysqli_fetch_array($result)) {

			$WoeID .= $row["WoeID"] . "|";
			$name .= $row["Name"] . "|";
			$latitude .= $row["Latitude"] . "|";
			$longitude .= $row["Longitude"] . "|";
			$population .= $row["Population"] . "|";
			$description .= $row["Description"] . "|";
			$languages .= $row["Languages"] . "|"; 
			$climate .= $row["Climate"] . "|";
			$economy .= $row["Economy"] . "|";
			$history .= $row["History"] . "|";
		}

		$WoeID = explode("|", $WoeID);
		$name = explode("|", $name);
		$latitude = explode("|", $latitude);
		$longitude = explode("|", $longitude);
		$population = explode("|", $population);
		$description = explode("|", $description);
		$languages = explode("|", $languages);
		$climate = explode("|", $climate);
		$economy = explode("|", $economy);
		$history = explode("|", $history);

		// export data to javascript
		echo '<script>';

		echo 'var WoeID = ' . json_encode($WoeID) . ';';
		echo 'var names = ' . json_encode($name) . ';';
		echo 'var latitude = ' . json_encode($latitude) . ';';
		echo 'var longitude = ' . json_encode($longitude) . ';';
		echo 'var population = ' . json_encode($population) . ';';
		echo 'var description = ' . json_encode($description) . ';';
		echo 'var languages = ' . json_encode($languages) . ';';
		echo 'var climate = ' . json_encode($climate) . ';';
		echo 'var economy = ' . json_encode($economy) . ';';
		echo 'var country_hist = ' . json_encode($history) . ';';

		echo '</script>';

	} else {
		echo "Failed to get data from Country table";
	}
	// -----------------------------------------------------------------------------------------------

	$RegionId = "";
	$WoeID = "";
	$name = "";
	$latitude = "";
	$longitude = "";
	$population = "";
	$description = "";
	$languages = "";
	$climate = "";
	$economy = "";
	$history = "";

	// -----------------------------------------------------------------------------------------------
	/* Query data from Region table */

	$query = "SELECT * FROM Region";

	if($result = mysqli_query($link, $query)) {

		while ($row = mysqli_fetch_array($result)) {

			$RegionId .= $row["RegionId"] . "|";
			$WoeID .= $row["WoeID"] . "|";
			$name .= $row["Name"] . "|";
			$latitude .= $row["Latitude"] . "|";
			$longitude .= $row["Longitude"] . "|";
			$population .= $row["Population"] . "|";
			$description .= $row["Description"] . "|";
			$languages .= $row["Languages"] . "|"; 
			$climate .= $row["Climate"] . "|";
			$economy .= $row["Economy"] . "|";
			$history .= $row["History"] . "|";
		}

		$RegionId = explode("|", $RegionId);
		$WoeID = explode("|", $WoeID);
		$name = explode("|", $name);
		$latitude = explode("|", $latitude);
		$longitude = explode("|", $longitude);
		$population = explode("|", $population);
		$description = explode("|", $description);
		$languages = explode("|", $languages);
		$climate = explode("|", $climate);
		$economy = explode("|", $economy);
		$history = explode("|", $history);

		// export data to javascript
		echo '<script>';

		echo 'var region_ID = ' . json_encode($RegionId) . ';';
		echo 'var region_WoeID = ' . json_encode($WoeID) . ';';
		echo 'var region_names = ' . json_encode($name) . ';';
		echo 'var region_latitude = ' . json_encode($latitude) . ';';
		echo 'var region_longitude = ' . json_encode($longitude) . ';';
		echo 'var region_population = ' . json_encode($population) . ';';
		echo 'var region_description = ' . json_encode($description) . ';';
		echo 'var region_languages = ' . json_encode($languages) . ';';
		echo 'var region_climate = ' . json_encode($climate) . ';';
		echo 'var region_economy = ' . json_encode($economy) . ';';
		echo 'var region_hist = ' . json_encode($history) . ';';

		echo '</script>';

	} else {
		echo "Failed to get data from Region table";
	}

?>