// html of article
var HTMLarticle = '<article></article>';

// html of wine title
var HTMLwineTitle = '<div class="row lead"><div class="col-md-12"><h1 class="wine-title">%wine-title%</h1></div></div>';

// html row bootstrap
var HTMLbootstrapRow = '<div class="row"></div>';

// htlm wine info
var HTMLwineInfo = '<div class="col-md-6"><p class="wine-desc">%description%</p><br/></br>' 
+ '<div class="details-info"><h5>%producer%</h5><h5>%type%</type><h5>%alcohol%</h5></div></div>';

// html wine image
var HTMLwineImage = '<div class="col-md-3 thumbnail"><img class="img-responsive wine-image" alt="wine-image" src="%imageURL%" /></div>';
// html price session
var HTMLpriceSession = '<div class="col-md-3 price-session"><h3 class="price-title text-center">Price</h3><p class="price-text text-center">%price%<br/><br/></p></div>';

// html horizontal rule
var HTMLhorizontalRule = '<div class="row"><div class="col-md-12"><hr></div></div>';

var HTMLregionHeader = '<h1 id="region-title">%region%</h1>';

if (typeof regionName !== 'undefined' && regionName !== null) {
	HTMLregionHeader = HTMLregionHeader.replace("%region%", "Wines produced in " + regionName);
}

if (typeof countryName !== 'undefined' && countryName !== null) {
	HTMLregionHeader = HTMLregionHeader.replace("%region%", "Wines produced in " + countryName);
}

var weather_settings = {
  "async": true,
  "crossDomain": true,
  "url": "http://api.openweathermap.org/data/2.5/weather?lat=" + latitude + "&lon=" + longitude + "&units=metric&appid=1800206b5f583afb545ea16de7b7c7e1",
  "method": "GET",
  "headers": {},
  "data": "{}"
}

var forecast_settings = {
  "async": true,
  "crossDomain": true,
  "url": "http://api.openweathermap.org/data/2.5/forecast/daily?lat=" + latitude + "&lon=" + longitude + "&units=metric&appid=1800206b5f583afb545ea16de7b7c7e1",
  "method": "GET",
  "headers": {},
  "data": "{}"
}

/* Fetch current weather */
$.ajax(weather_settings).done(function (response) {

  var weatherMain = response.weather[0].main;
  var weatherDescription = response.weather[0].description;
  var iconId = response.weather[0].icon;

  var iconURL = "http://openweathermap.org/img/w/" + iconId + ".png";

  var pressure = response.main.pressure;
  var humidity = response.main.humidity;
  var maxTemp = response.main.temp_max;
  var minTemp = response.main.temp_min;

  var windSpeed = response.wind.speed;
  var windDegree = response.wind.deg;

  $('#weather-icon').html("<img src='" + iconURL + "'/>");
  $('#weather-description').html(toUpperCaseWeatherDescription(weatherDescription));
  $('#weather-pressure').html(pressure + " hPa");
  $('#weather-humidity').html(humidity + " %");
  $('#weather-maxtemp').html(maxTemp + " &#8451;");
  $('#weather-mintemp').html(minTemp + " &#8451;");
  $('#weather-windspeed').html(windSpeed + " km/h");
  $('#weather-winddegree').html(windDegree + "&#176;");

});

/* Fetch weather forecast for the next 7 days */
$.ajax(forecast_settings).done(function (response) {

  var HTMLForecastTable = "<table id='forecast-table'></table>";
  var HTMLTableRow = "<tr>" + 
  					 "<td class='forecast-text'><b>%date%</b></td>" + 
  					 "<td><img src='%icon%'/></td>" + 
  					 "<td class='forecast-text'><b>%temp%</b></td>" + 
  					 "</tr><tr><td><hr/></td><td><hr/></td><td><hr/></td></tr>";

  var list = response.list;

  var weekDay = new Array(7);
  weekDay[0] = "Sunday";
  weekDay[1] = "Monday";
  weekDay[2] = "Tuesday";
  weekDay[3] = "Wednesday";
  weekDay[4] = "Thursday";
  weekDay[5] = "Friday";
  weekDay[6] = "Saturday";

  var date = new Date();

  var forecast = $('#forecast');
  forecast.append(HTMLForecastTable);

  var forecastTable = $('#forecast-table');

  for (day in list) {
  	date.setDate(date.getDate() + 1);
  	var wday = date.getDate() + "<br/>" + weekDay[date.getDay()];

  	var maxTemp = list[day].temp.max;
  	var iconId = list[day].weather[0].icon;

  	var iconURL = "http://openweathermap.org/img/w/" + iconId + ".png";

  	var formattedHTMLTableRow = HTMLTableRow.replace('%date%', wday);
  	formattedHTMLTableRow = formattedHTMLTableRow.replace('%icon%', iconURL);
  	formattedHTMLTableRow = formattedHTMLTableRow.replace('%temp%', maxTemp + " &#8451;");

  	forecastTable.append(formattedHTMLTableRow);

  }

});

$('#region-header-session').append(HTMLregionHeader);

var mainTag = $('#mainTag');

for (var i = 0; i < num_rows ; i++) {
	// replace with actual name
	var formattedHTMLwineTitle = HTMLwineTitle.replace("%wine-title%", wineNames[i]);

	// replace with actual info
	var formattedHTMLwineInfo = HTMLwineInfo.replace("%description%", wineDescription[i]);
	formattedHTMLwineInfo = formattedHTMLwineInfo.replace("%producer%", "Producer: " + suppliers[i]);
	formattedHTMLwineInfo = formattedHTMLwineInfo.replace("%type%", "Type: " + type[i]);
	formattedHTMLwineInfo = formattedHTMLwineInfo.replace("%alcohol%", "Alcohol: " + alcohol[i] + "%");

	// replace with actual image url
	var formattedHTMLwineImage = HTMLwineImage.replace("%imageURL%", image_url[i]);

	// replace with actual price
	var formattedHTMLpriceSession = HTMLpriceSession.replace("%price%", generatePrice(price[i]));

	// append article tag
	mainTag.append(HTMLarticle);

	var article;

	if (mainTag.find('article').length === 1) {

		article = $('article');

	} else {
		// get the first article tag, which is the first child of the main tag
		article = mainTag.children().first();

		// then move to the most recently added 
		for (var j = 0; j < mainTag.find('article').length - 1; j++) {
			article = article.next();
		}

	}

	article.append(formattedHTMLwineTitle);
	article.append(HTMLbootstrapRow);

	var selectRow = article.children().first().next();

	selectRow.append(formattedHTMLwineInfo);
	selectRow.append(formattedHTMLwineImage);
	selectRow.append(formattedHTMLpriceSession);

	article.append(HTMLhorizontalRule);
}


function generatePrice(price) {
	var pricePerBottle = "£" + price + " PER BOTTLE<br/><br/>";

	var priceTotal = "£" + Math.round(price*12) + " CASE OF 12";

	return pricePerBottle + priceTotal; 
}

function toUpperCaseWeatherDescription(weatherDesc) {
	return weatherDesc.slice(0, 1).toUpperCase() + weatherDesc.slice(1).toLowerCase();
}

