<!DOCTYPE html>
<html>
  <head>

    <title>Wine regions</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
    

    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="css/main.css" rel="stylesheet" type="text/css">

    <link href="https://fonts.googleapis.com/css?family=Pacifico|Yesteryear" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>


    <?php
      include "php/fetchRegions.php";
    ?>

    <script>
    	function changeBackground() {
    		$(window).on('beforeunload', function() {
        		$(window).scrollTop(0);
    		});

    		var order = 1;
    		setInterval(function() {
        		order++;
        		if (order <= 4) {
        			var img = 'url(images/background' + order + '.jpg)';
            		$('#parallax').css('background-image', img);
        		} else {
            		order = 1;
            		var img = 'url(images/background' + order + '.jpg)';
            		$('#parallax').css('background-image', img);
        		}
    		}, 4000);

    		$('.scroll').click(function() {
        		$('html, body').animate({scrollTop: $(document).height() - 500}, 1500);
    		});

		}	
    </script>

  </head>

  <body class="container-fluid" onload="changeBackground()">

    <header>
      <div class="row">
        <div class="col-md-3">
          <img class="img-responsive" id="wine-logo" src="images/wine_logo.png" alt="wine-logo" />
        </div>

        <div class="col-md-9 text-center">
          <h1 id="page-title">Wine Countries/Regions in the world</h1>
        </div>
      </div>
    </header>

    <div class="explore-text">
      <h1 class="scroll" id="exp-text">Vineyards<br/> and<br/> Wines</h1>
    </div>

    <div class="scroll parallax" id="parallax" style="background-image: url('images/background1.jpg');">
    </div>
    

    <br/>
    <br/>
    <br/>
    <br/>

    <main>
      <div class="row">
        <div class="col-md-6 col-xs-6 map-session">
          <hr/>
          <h2 class="map-name text-center">Countries Producing Wines Map</h2>
          <br/>
          <div class="map" id="regionMap"></div>
        </div>

        <div class="col-md-6 col-xs-6 map-session">
          <hr/>
          <h2 class="map-name text-center">Regions Producing Wines in France</h2>
          <br/>
          <div class="map" id="wineMap"></div>
        </div>
      </div>
    </main>

    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>

    <footer>

    	<a href="php/wine_to_rss.php">RSS Feed</a>
    	&nbsp;|&nbsp;

    	<a href="xml/configuration.xml">Configuration XML</a>
    	&nbsp;|&nbsp;

    	<a href="xml/configuration.xsd">Configuration XSD</a>
    	&nbsp;|&nbsp;

    	&nbsp;<b>-</b>&nbsp;
  		Team members: Khoa Phung - Zheenyar Karim - Abidur Rahman - Hamse Hussein&nbsp;

  		&nbsp;<b>-</b>&nbsp;
  		Copyright &copy; UWE DSA Project


    </footer>
  
    
    <script type="text/javascript" src="js/main.js"></script>

    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyACC6G2UjsfaZuFLZomrc_hQHJYew3wtX8&callback=initMap">
    </script>  

  </body>

</html>