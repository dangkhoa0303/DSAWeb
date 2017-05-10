<!DOCTYPE html>
<html>
  <head>

    <title>Wines</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
    

    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="css/details.css" rel="stylesheet" type="text/css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

    <?php
      include "php/connection.php";
		  include "php/wineData.php";
    ?>


  </head>

  <body class="container-fluid">

  <header>
    <div class="row">
      <div class="col-md-3">
        <img class="img-responsive" id="wine-logo" src="images/wine_logo.png" alt="wine-logo" />
      </div>

      <div class="col-md-5 text-center" id="region-header-session">
        
      </div>

      <div class="col-md-4" id="weather-session">

        <h4 class="weather-forecast">Current weather</h4>

        <table class="weather-text">
          <tr>
            <td class="weather-col"><b>Main</b></td>
            <td class="weather-col" id="weather-icon"></td>
            <td class="weather-col"><b>Description</b></td>
            <td class="weather-col" id="weather-description"></td>
          </tr>

          <tr>
            <td class="weather-col"><b>Pressure</b></td>
            <td class="weather-col" id="weather-pressure"></td>
            <td class="weather-col"><b>Humidity</b></td>
            <td class="weather-col" id="weather-humidity"></td>
          </tr>

          <tr>
            <td class="weather-col"><b>Max temp</b></td>
            <td class="weather-col" id="weather-maxtemp"></td>
            <td class="weather-col"><b>Min temp</b></td>
            <td class="weather-col" id="weather-mintemp"></td>
          </tr>

          <tr>
            <td class="weather-col"><b>Wind speed</b></td>
            <td class="weather-col" id="weather-windspeed"></td>
            <td class="weather-col"><b>Wind degree</b></td>
            <td class="weather-col" id="weather-winddegree"></td>
          </tr>
        </table>
        
      </div>
    </div>
  </header>

  <main class="container-fluid">

    <div class="row row-centered">
      <div class="col-md-9" id="mainTag">

      </div>

      <div class="col-md-3 text-center" id="forecast">
        <h3 class="weather-forecast">Forecast for 7 days</h3>
        <hr/>

      </div>
    </div>
  	
  </main>

  <footer>
    Team members: Khoa Phung - Zheenyar Karim - Abidur Rahman - Hamse Hussein&nbsp;
    
    &nbsp;<b>-</b>&nbsp;
    Copyright &copy; UWE DSA Project
  </footer>
  

  <script type="text/javascript" src="js/detailsBuilder.js"></script>     

  </body>

</html>