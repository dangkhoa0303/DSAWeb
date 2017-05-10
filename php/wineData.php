<?php

	$countryID = $_GET["countryID"];

	$check = true; // select from country map

	// if country map is selected --> no regionID passed
	if (empty($_GET["regionID"])) {
		$query = "SELECT WineID, Name, Alcohol, Colour, Description, Price, Image, Age FROM Wine WHERE WoeID=" . $countryID; 

		// SELECT Type FROM Wine w INNER JOIN WineType wt ON w.TypeID=wt.TypeID WHERE w.WoeID=$countryID
		$query_type = "SELECT Type FROM Wine w INNER JOIN WineType wt ON w" . ".TypeID=wt" . ".TypeID WHERE w" . ".WoeID=" . $countryID;

		// SELECT Supplier FROM Wine w INNER JOIN Supplier s ON w.SupplierID=s.SupplierID WHERE w.WoeID=$countryID
		$query_supplier = "SELECT Supplier FROM Wine w INNER JOIN Suppliers s ON w" . ".SupplierID=s" . ".SupplierID WHERE w" . ".WoeID=" . $countryID;

		$query_geo = "SELECT Latitude, Longitude FROM Country WHERE WoeID=" . $countryID;

		$countryName = $_GET["countryName"];

	} else { // if region map is selected -> regionID passed
		$regionID = $_GET["regionID"];

		$query = "SELECT WineID, Name, Alcohol, Colour, Description, Price, Image, Age FROM Wine WHERE RegionId=" . $regionID; 

		// SELECT Type FROM Wine w INNER JOIN WineType wt ON w.TypeID=wt.TypeID WHERE w.regionId=$regionID
		$query_type = "SELECT Type FROM Wine w INNER JOIN WineType wt ON w" . ".TypeID=wt" . ".TypeID WHERE w" . ".RegionId=" . $regionID;

		// SELECT Supplier FROM Wine w INNER JOIN Supplier s ON w.SupplierID=s.SupplierID WHERE w.regionId=$regionID
		$query_supplier = "SELECT Supplier FROM Wine w INNER JOIN Suppliers s ON w" . ".SupplierID=s" . ".SupplierID WHERE w" . ".RegionId=" . $regionID;

		$query_geo = "SELECT Latitude, Longitude FROM Region WHERE RegionId=" . $regionID . " AND WoeID=" . $countryID;

		$regionName = $_GET["regionName"];

		$check = false;
	}
	// -------------------------------------------------------------------------------------------------------------------------------------------------

	/* Query Country or Region table to get latitude and longitude */

	$result_geo = mysqli_query($link, $query_geo);
	$num_rows = mysqli_num_rows($result_geo);

	if ($num_rows > 0) {
		$row = mysqli_fetch_array($result_geo);
		$latitude = $row["Latitude"];
		$longitude = $row["Longitude"];
	}

	echo '<script>';

	echo 'var latitude = ' . json_encode($latitude) . ";";
	echo 'var longitude = ' . json_encode($longitude) . ";";

	if ($check) {
		echo 'var countryName = ' . json_encode($countryName) . ";";
	} else {
		echo 'var regionName = ' . json_encode($regionName) . ";";
	}

	echo '</script>';

	/* End Querying for Latitude and Longitude ==> Exported to javascript */

	// -------------------------------------------------------------------------------------------------------------------------------------------------

	/* Query Wine and WineType tables on inner join */

	$result_type = mysqli_query($link, $query_type);
	$num_rows = mysqli_num_rows($result_type);

	$type = "";

	if ($num_rows > 0) {
		while ($row = mysqli_fetch_array($result_type)) {
			//$typeID .= $row["TypeID"] . "|";
			$type .= $row["Type"] . "|";
		}

		//$typeID = explode("|", $typeID);
		$type = explode("|", $type);
	}

	/*End Querying WineType table */

	// -------------------------------------------------------------------------------------------------------------------------------------------------

	/* Query Wine and Suppliers tables on inner join */

	$result_supplier = mysqli_query($link, $query_supplier);
	$num_rows = mysqli_num_rows($result_supplier);

	$suppliers = "";

	if ($num_rows > 0) {
		while ($row = mysqli_fetch_array($result_supplier)) {
			$suppliers .= $row["Supplier"] . "|";
		}

		$suppliers = explode("|", $suppliers);
	}

	/*End Querying Suppliers table */

	// -------------------------------------------------------------------------------------------------------------------------------------------------

	/* Variables used to store data fromWine table */

	$WineID = "";
	$name = "";
	$alcohol = "";
	$colour = "";
	$description = "";
	$price = "";
	$image_url = "";
	$age = "";

	// -------------------------------------------------------------------------------------------------------------------------------------------------
	
	/* Query Wine table */

	$result = mysqli_query($link, $query);

	$num_rows = mysqli_num_rows($result);

	if ($num_rows > 0) {
		
		// extract data from query result
		while ($row = mysqli_fetch_array($result)) {
			$WineID .= $row["WineID"] . "|";
			$name .= $row["Name"] . "|";
			$alcohol .= $row["Alcohol"] . "|";
			$colour .= $row["Colour"] . "|";
			$description .= $row["Description"] . "|";
			$price .= $row["Price"] . "|";
			$image_url .= $row["Image"] . "|";
			$age .= $row["Age"] . "|";
		}

		$WineID = explode("|", $WineID);
		$name = explode("|", $name);
		$alcohol = explode("|", $alcohol);
		$colour = explode("|", $colour);
		$description = explode("|", $description);
		$price = explode("|", $price);
		$image_url = explode("|", $image_url);
		$age = explode("|", $age);

		/*End Querying Wine table */

		// -------------------------------------------------------------------------------------------------------------------------------------------------

		/* Export data to javascript */
		echo '<script>';

		echo 'var num_rows = ' . json_encode($num_rows) . ";";

		echo 'var wineID = ' . json_encode($WineID) . ';';
		echo 'var wineNames = ' . json_encode($name) . ';';
		echo 'var type = ' . json_encode($type) . ';';
		echo 'var alcohol = ' . json_encode($alcohol) . ';';
		echo 'var colour = ' . json_encode($colour) . ';';
		echo 'var wineDescription = ' . json_encode($description) . ';';
		echo 'var price = ' . json_encode($price) . ';';
		echo 'var image_url = ' . json_encode($image_url) . ';';
		echo 'var age = ' . json_encode($age) . ';';
		echo 'var suppliers = ' . json_encode($suppliers) . ';';

		echo '</script>';

	} 
?>