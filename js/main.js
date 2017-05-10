const WOEID = 0;
const NAME = 1;
const LAT = 2;
const LON = 3;
const POPULATION = 4;
const DESCRIPTION = 5;
const LANGUAGES = 6;
const CLIMATE  = 7;
const ECONOMY = 8;
const HISTORY = 9;

const R_ID = 0;
const R_WOEID = 1;
const R_NAME = 2;
const R_LAT = 3;
const R_LON = 4;
const R_POPULATION = 5;
const R_DESCRIPTION = 6;
const R_LANGUAGES = 7;
const R_CLIMATE  = 8;
const R_ECONOMY = 9;
const R_HISTORY = 10;

/* Individual task */
var flickr_api_key = "d5e60e733cce0c77ee9f835a64a50487";
var API_KEY = "&api_key=" + flickr_api_key;
var TAG = "&tags=";
var LATITUDE = "&lat=";
var LONGITUDE = "&lon=";
var PER_PAGE = "&per_page=10";
var FORMAT = "&format=json"; 
var JSON_CALLBACK = "&nojsoncallback=1";

var flickr_settings = {
    "async": true,
    "crossDomain": true,
    "method": "GET",
    "headers": {},
    "data": "{}"
}


// variables to store images locally and temporarily while cookie still exists
var countries_photos = [];
var regions_photos = [];

/* == End Individual task */

// store all information from table 'Country' and 'Region'
var countries = [];
var regions = [];

// fetch all entries from 'Country' table into countries variable
function fetchData() {

    // store countries info into countries variable
    for (var i = 0; i < names.length; i++) {
		var row = [];

        var j = 0;
        while (j < names.length - 1) {

        	row[j++] = WoeID[i];
            row[j++] = names[i];
            row[j++] = latitude[i];
            row[j++] = longitude[i];
            row[j++] = population[i];
            row[j++] = description[i];
            row[j++] = languages[i];
            row[j++] = climate[i];
            row[j++] = economy[i];
            row[j++] = country_hist[i];
        }
        countries[i] = row;
    }

    // store regions info into regions variable
    for (var i = 0; i < region_names.length; i++) {
        var row = [];

        var j = 0;
        while (j < region_names.length - 1) {

            row[j++] = region_ID[i];
            row[j++] = region_WoeID[i];
            row[j++] = region_names[i];
            row[j++] = region_latitude[i];
            row[j++] = region_longitude[i];
            row[j++] = region_population[i];
            row[j++] = region_description[i];
            row[j++] = region_languages[i];
            row[j++] = region_climate[i];
            row[j++] = region_economy[i];
            row[j++] = region_hist[i];

        }
        regions[i] = row;
    }
}

function initMap() {
    fetchData();

    initCountryMap();
    initRegionMap();
}

function initCountryMap() {
    var myLatLng = {lat: 10, lng: 33};

    var map = new google.maps.Map(document.getElementById('regionMap'), {
        zoom: 2,
        center: myLatLng,
        mapTypeId: 'terrain',
    });  

    // support marker click
    var infowindow = new google.maps.InfoWindow({
        maxWidth: 600
    });

    var marker;

    var wineIcon = {
        url: 'images/wine_icon.png',
        scaledSize: new google.maps.Size(64, 64)
    };

    // pin markers on map
    for (var i = 0; i < countries.length - 1; i++) {  
        marker = new google.maps.Marker({
            position: new google.maps.LatLng(parseFloat(countries[i][LAT]), parseFloat(countries[i][LON])),
            map: map,
            icon: wineIcon
        });

        google.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
            return function() {

                /* Individual task */

                var checkName = $('#country-name');
                /* Check to see if the window info is already open or not */
                if (checkName.html() !== countries[i][NAME]) {
                    infowindow.setContent(countryInfoWindowContent(i));
                    infowindow.open(map, marker);

                    var cname = generateCountryCookieName(countries[i][NAME], countries[i][WOEID]);
                    var cvalue = "image";

                    // If cookie doeas not exist
                    if (!checkCookie(cname) || countries_photos.length === 0) {
                        // set cookie
                        setCookie(cname, cvalue);

                        var tag = generateTag(countries[i][NAME]);
                        fetchFlickr(tag, i, "country");
                    } else {
                        fetchPhotosLocally(countries_photos, i);
                    }
                
                    
                } else {
                    // If it is already open, don't do anything else
                    // do nothing here
                }
                /* == End Individual task */              
            } 
        })
        (marker, i));

        google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                window.location.href = "details.php?countryID=" + countries[i][WOEID] + "&countryName=" + countries[i][NAME];    
            } 
        })
        (marker, i));
    }
}

function initRegionMap() {

    var myLatLng = {lat: 46.2276, lng: 2.2137};

    var map = new google.maps.Map(document.getElementById('wineMap'), {
        zoom: 6,
        center: myLatLng,
        mapTypeId: 'terrain'
    });  

    // support marker click
    var infowindow = new google.maps.InfoWindow({
        maxWidth: 600
    });

    var marker;

    var wineIcon = {
        url: 'images/wine_icon.png',
        scaledSize: new google.maps.Size(64, 64)
    };

    // pin markers on map
    for (var i = 0; i < regions.length - 1; i++) {  
        marker = new google.maps.Marker({
            position: new google.maps.LatLng(parseFloat(regions[i][R_LAT]), parseFloat(regions[i][R_LON])),
            map: map,
            icon: wineIcon
        });

        google.maps.event.addListener(marker, 'mouseover', (function(marker, i) {
            return function() {

                /* Individual task */

                var checkName = $('#region-name');

                if (checkName.html() !== regions[i][R_NAME]) {
                    infowindow.setContent(regionInfoWindowContent(i));
                    infowindow.open(map, marker);

                    var cname = generateRegionCookieName(regions[i][R_NAME], regions[i][R_ID], regions[i][R_WOEID]);
                    var cvalue = "image";

                    // If cookie doeas not exist
                    if (!checkCookie(cname) || regions_photos.length === 0) {
                        // set cookie
                        setCookie(cname, cvalue);

                        var tag = generateTag(regions[i][R_NAME]);
                        fetchFlickr(tag, i, "region");
                    } else {
                        fetchPhotosLocally(regions_photos, i);
                    }
                } else {
                    // do nothing here
                }
                /* == End Individual task */
            } 
        })
        (marker, i));

        google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                window.location.href = "details.php?regionID=" + regions[i][R_ID] + "&regionName=" + regions[i][R_NAME] + "&countryID=" + regions[i][R_WOEID];    
            } 
        })
        (marker, i));
    }
}

function fetchFlickr(tag, i, type) {
    var formattedURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search" + API_KEY + PER_PAGE + FORMAT + JSON_CALLBACK + TAG + tag;

    flickr_settings.url = formattedURL;

    $.ajax(flickr_settings).done(function(response) {

        var photos = response.photos.photo;
        var array_photos = [];
                    
        for (photo in photos) {
            var photo_id = photos[photo].id;
            var secret_id = photos[photo].secret;
            var server_id = photos[photo].server;
            var farm_id = photos[photo].farm;            
            var size = "m";

            // generate photo url
            var photo_url = 'http://farm' + farm_id + '.staticflickr.com/' + server_id + '/' + photo_id + '_' + secret_id + '_' + size + '.jpg'; 
            
            // generate HTML image element
            var HTMLimage = "<div class='col-md-6'><img class='img-responsive thumbnail flickr-img' src='" + photo_url + "'/></div>";

            array_photos[photo] = HTMLimage;

            $('.flickr-info-section').append(HTMLimage);
        }

        if (type === "country") {
        	countries_photos[i] = array_photos;
        } else {
        	regions_photos[i] = array_photos;
        }

    });
}

function countryInfoWindowContent(i) {
    var content = "<section class='container-fluid' id='country-info'><div class='row'>" +
                    "<div class='col-md-12'>" +
                    "<h4 id='country-name'>" + countries[i][NAME] + "</h4>" +
                    "<p>" + countries[i][DESCRIPTION] + "</p>" +
                    "<p><b>Latitude: </b>" + countries[i][LAT] + "</p>" +
                    "<p><b>Longitude: </b>" + countries[i][LON] + "</p>" +
                    "<p><b>Population: </b>" + countries[i][POPULATION] + " million people</p>" +
                    "<p><b>Language: </b>" + countries[i][LANGUAGES] + "</p>" +
                    "<p><b>Climate: </b>" + countries[i][CLIMATE] + "</p>" +
                    "</div>" + 
                    "</div>" +
                    "<div class='row flickr-info-section'>" +
                    "</div></section>";
    return content;
}

function regionInfoWindowContent(i) {
    var content = "<section class='container-fluid' id='region-info'><div class='row'>" +
                    "<div class='col-md-12'>" +
                    "<h4 id='region-name'>" + regions[i][R_NAME] + "</h4>" +
                    "<p>" + regions[i][R_DESCRIPTION] + "</p>" +
                    "<p><b>Latitude: </b>" + regions[i][R_LAT] + "</p>" +
                    "<p><b>Longitude: </b>" + regions[i][R_LON] + "</p>" +
                    "<p><b>Population: </b>" + regions[i][R_POPULATION] + " million people</p>" +
                    "<p><b>Language: </b>" + regions[i][R_LANGUAGES] + "</p>" +
                    "<p><b>Climate: </b>" + regions[i][R_CLIMATE] + "</p>" +
                    "</div>" + 
                    "</div>" +
                    "<div class='row flickr-info-section'>" +
                    "</div></section>";
    return content;
}

/* Individual task */

/* function to generate flickr tags */
function generateTag(tags) {
    var return_tag = tags.replace(" ", "%20");

    return return_tag + ",wine";
}

/* 
function to set cookie for each country or region 
-- images will be saved locally while cookie exists (2 minutes)
-- flickr api will not be called if cookie exists
*/
function setCookie(cname, cvalue) {
	var date = new Date();
	// set cookie for 2 minutes
	date.setTime(date.getTime() + 2*60*1000);
	var expires = "expires=" + date.toUTCString();
	document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/;";
}

/* function to check whether cookie exists or not */
function checkCookie(cname) {
	var allCookies = document.cookie;
	cname = cname.trim();

	var cookieArray = allCookies.split(";");

	for (cookie in cookieArray) {
		var cookieName = cookieArray[cookie].split("=")[0].trim();
		if (cookieName == cname) {
			return true;
		}
	}
	return false;
}

/* function to create cookie name */
function generateCountryCookieName(countryName, countryID) {
	countryName = countryName.trim().replace(" ", "");
	var string =  countryName + countryID;
	return string;
}

/* function to create region cookie name */
function generateRegionCookieName(regionName, regionID, countryID) {
	var string = regionName + regionID + countryID;
	return string;
}

/* function to fetch photos while cookie still exists */
function fetchPhotosLocally(array_photos, i) {
	for (photo in array_photos[i]) {
		$('.flickr-info-section').append(array_photos[i][photo]);
	}
}
/* == End Individual task */