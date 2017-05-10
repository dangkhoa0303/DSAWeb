-- Table `Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Country` (
  `WoeID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Latitude` DOUBLE NOT NULL,
  `Longitude` DOUBLE NOT NULL,
  `Population` DOUBLE NULL,
  `Description` VARCHAR(3000) NULL,
  `Languages` VARCHAR(200) NULL,
  `Climate` VARCHAR(150) NULL,
  `Economy` VARCHAR(500) NULL,
  `History` VARCHAR(2000) NULL,
  UNIQUE (`Name`),
  CONSTRAINT `WoeID` PRIMARY KEY (`WoeID`)
 );

-- Table `Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Region` (
  `RegionId` INT NOT NULL AUTO_INCREMENT,
  `WoeID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Latitude` DOUBLE NOT NULL,
  `Longitude` DOUBLE NOT NULL,
  `Population` DOUBLE NULL,
  `Description` VARCHAR(3000) NULL,
  `Languages` VARCHAR(200) NULL,
  `Climate` VARCHAR(150) NULL,
  `Economy` VARCHAR(500) NULL,
  `History` VARCHAR(2000) NULL,
  UNIQUE (`Name`),
  CONSTRAINT `RegionId` PRIMARY KEY (`RegionId`),
  CONSTRAINT `Region_WoeID` FOREIGN KEY (`WoeID`) REFERENCES `Country` (`WoeID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS `WineType` (
  `TypeID` INT NOT NULL AUTO_INCREMENT,
  `Type` VARCHAR(50) NOT NULL,
  UNIQUE(`Type`),
  CONSTRAINT `TypeID` PRIMARY KEY (`TypeID`)
);

CREATE TABLE IF NOT EXISTS `Suppliers` (
  `SupplierID` INT NOT NULL AUTO_INCREMENT,
  `Supplier` VARCHAR(50) NOT NULL,
  UNIQUE (`Supplier`),
  CONSTRAINT `SupplierID` PRIMARY KEY (`SupplierID`)
);

-- -----------------------------------------------------
-- Table `Wine`
-- -----------------------------------------------------
-- don't set regionId as the foreign key related to Region table
-- regionId can be set to 0 which means that the wine does not belong to any specific region. It just belongs to the country

CREATE TABLE IF NOT EXISTS `Wine` (
  `WineID` INT NOT NULL AUTO_INCREMENT,
  `WoeID` INT NOT NULL,
  `TypeID` INT NOT NULL,
  `SupplierID` INT NOT NULL,
  `RegionId` INT NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Alcohol` DOUBLE NOT NULL,
  `Colour` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(2000) NOT NULL,
  `Price` DOUBLE NOT NULL,
  `Image` VARCHAR(500) NULL,
  `Age` INT NULL,
  UNIQUE (`Name`),
  CONSTRAINT `WineID` PRIMARY KEY (`WineID`),
  CONSTRAINT `Wine_WoeID` FOREIGN KEY (`WoeID`) REFERENCES `Country` (`WoeID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  CONSTRAINT `Wine_TypeID` FOREIGN KEY (`TypeID`) REFERENCES `WineType` (`TypeID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  CONSTRAINT `Wine_SupplierID` FOREIGN KEY (`SupplierID`) REFERENCES `Suppliers` (`SupplierID`)
  ON DELETE CASCADE
  ON UPDATE CASCADE
);

INSERT INTO `Country` (`WoeID`, `Name`, `Latitude`, `Longitude`, `Population`, `Description`, `Languages`, `Climate`, `Economy`, `History`) VALUES
("1", "France", "46.2276", "2.2137", "66.03", "France, in Western Europe, encompasses medieval cities, alpine villages and Mediterranean beaches. Paris, its capital, is famed for its fashion houses, classical art museums including the Louvre and monuments like the Eiffel Tower. The country is also renowned for its wines and sophisticated cuisine. Lascaux's ancient cave drawings, Lyon's Roman theater and the vast Palace of Versailles attest to its rich history.",
"French", "Oceanic climate", "A member of the Group of 7 (formerly G8) leading industrialised countries, as of 2014, it is ranked as the world's ninth largest and the EU's second largest economy by purchasing power parity.", "The oldest traces of human life in what is now France date from approximately 1.8 million years ago."),

("2", "Portugal", "39.3999", "-8.2245", "10.46", "Portugal is a southern European country on the Iberian Peninsula, bordering Spain. Its location on the Atlantic Ocean has influenced many aspects of its culture like salt cod and grilled sardines are national dishes, the Algarve's beaches are a major destination and much of the nation's architecture dates to the 1500s-1800s, when Portugal had a powerful maritime empire.", 
"Portuguese", "Mediterranean climate", "Portugal is a developed and a high-income country, with its GDP per capita in 2014.", "The name of Portugal derives from the joined Romano Celtic name Portus Cale."),

("3", "New Zealand", "-40.9006", "174.8860", "4.471", "New Zealand is a country in the southwestern Pacific Ocean consisting of 2 main islands, both marked by volcanoes and glaciation. Capital Wellington, on the North Island, is home to Te Papa Tongarewa, the expansive national museum. Wellington's dramatic Mt. Victoria, along with the South Island's Fiordland and Southern Lakes, stood in for mythical Middle Earth in Peter Jackson's - Lord of the Rings films.",
"New Zealand English", "Maritime climate", "New Zealand has a high-income economy with a nominal gross domestic product (GDP) per capita of US $36,254.", "New Zealand was one of the last major landmasses settled by humans."),

("4", "Italy", "41.8719", "12.5674", "59.83", "Italy, a European country with a long Mediterranean coastline, has left a powerful mark on Western culture and cuisine. Its capital, Rome, is home to the Vatican as well as landmark art and ancient ruins. Other major cities include Florence, with Renaissance masterpieces such as Michelangelo's David and Brunelleschi's Duomo like Venice, the city of canals and Milan, Italy's fashion capital.",
"Italian", "Climate ranges from humid subtropical to humid continental and oceanic", "Italy is regarded as one of the world's most industrialised nations and a leading country in world trade and exports.", "In the 14th and 15th centuries, northern central Italy was divided into a number of warring city states, the rest of the peninsula being occupied by the larger Papal States and the Kingdom of Sicily, referred to here as Naples."),

("5", "Argentina", "-38.416097", "-63.616672", "41.45", "Argentina is a massive South American nation with terrain encompassing Andes mountains, glacial lakes and Pampas grassland, the traditional grazing ground of its famed beef cattle. The country is famous for tango dance and music. Its big, cosmopolitan capital, Buenos Aires, is centered on the Plaza de Mayo, lined with stately 19th-century buildings including Casa Rosada, the iconic, balconied presidential palace.",
"Spanish", "Climate ranges from subtropical in the north to subpolar in the far south", "Benefiting from rich natural resources, a highly literate population, a diversified industrial base, and an export oriented agricultural sector, the economy of Argentina is Latin America's third-largest, and the second largest in South America.", "The history of Argentina is divided by historians into four main parts like the pre Columbian time or early history, the colonial period 1530-1810, the period of nation building 1810-1880, and the history of modern Argentina from around 1880."),

("6", "Germany", "51.165691", "10.451526", "80.62", "Germany is a Western European country with a landscape of forests, rivers, mountain ranges and North Sea beaches. It has over 2 millennia of history. Berlin, its capital, is home to art and nightlife scenes, the Brandenburg Gate and many sites relating to WWII. Munich is known for its Oktoberfest and beer halls, including the 16th-century Hofbrauhaus. Frankfurt, with its skyscrapers, houses the European Central Bank.",
"German", "Temperate seasonal climate", "Germany has a social market economy with a highly skilled labour force, a large capital stock, a low level of corruption, and a high level of innovation.", "The discovery of the Mauer 1 mandible shows that ancient humans were present in Germany at least 600,000 years ago."),

("7", "South Africa", "-30.559482", "22.937506", "54.9", "South Africa is a country on the southernmost tip of the African continent, marked by several distinct ecosystems. Inland safari destination Kruger National Park is populated by big game. The Western Cape offers beaches, lush winelands around Stellenbosch and Paarl, craggy cliffs at the Cape of Good Hope, forest and lagoons along the Garden Route, and the city of Cape Town, beneath flat-topped Table Mountain.",
"Afrikaans, English, Ndebele, Northern Sotho, Sotho, Swazi, Tswana, Tsonga, Venda, Xhosa, and Zulu", "Temperate climate", "South Africa has a mixed economy, the second largest in Africa after Nigeria.", "South Africa contains some of the oldest archaeological and human fossil sites in the world.");


INSERT INTO `Region` (`RegionId`, `WoeID`, `Name`, `Latitude`, `Longitude`, `Population`, `Description`, `Languages`, `Climate`, `Economy`, `History`) VALUES

("1", "1", "Bordeaux", "44.8378", "-0.5792", "239.157", "Bordeaux, hub of the famed wine growing region, is a port city on the Garonne River in southwestern France. It's known for its Gothic Cathedrale Saint Andre, 18th to 19th century mansions and notable art museums such as the Musee des Beaux Arts de Bordeaux. Public gardens line the curving river quays. The grand Place de la Bourse, centered on the Three Graces fountain, overlooks the Miroir d'Eau reflecting pool.",
"French", "Oceanic climate", "Bordeaux is a major centre for business in France as it has the fifth largest metropolitan population in France.", "In historical times, around 300 BC it was the settlement of a Celtic tribe, the Bituriges Vivisci, who named the town Burdigala, probably of Aquitanian origin. The name Bourde is still the name of a river south of the city."),

("2", "1", "Burgundy", "47.0525", "4.3837", "1.644", "Burgundy is a historical region in east-central France. It's famous for its Burgundy wines as well as Pinot Noirs and Chardonnays, Chablis and Beaujolais. The area is crisscrossed by a network of canals and studded with grand chateaux, some now luxury hotels. The capital, Dijon, of mustard fame, is home to the imposing Palace of the Dukes, where the distinguished Musee des Beaux-Arts was established in 1787.",
"French", "Half-continental climate", "Earlier, the southeastern part of Burgundy was heavily industrial, with coal mines near Montceau-les-Mines and iron foundries and crystal works in Le Creusot. These industries declined in the second half of the twentieth century, and Le Creusot has tried to reinvent itself as a tourist town.", "Historically, Burgundy has referred to numerous political entities, including kingdoms and duchies spanning territory from the Mediterranean to the Low Countries."),

("3", "1", "Champagne", "48.0266", "0.3332", "1.337", "The Champagne wine region is a historic province within the administrative province of Champagne in the northeast of France. The area is best known for the production of the sparkling white wine that bears the region's name.",
"French", "Oceanic climate", "While totally dominating the region's production, sparkling Champagne is not the only product that is made from the region's grapes. Non-sparkling still wines, like those made around the village Bouzy, are sold under the appellation label Coteaux Champenois.", "The Carolingian reign saw periods of prosperity for the Champagne region beginning with Charlemagne's encouragement for the area to start planting vines and continuing with the coronation of his son Louis the Pious at Reims."),

("4", "1", "Loire", "47.55324", "1.010529", "0.5", "The Loire is the longest river in France, stretching some 1,000km from its source in the south to the Atlantic coast a little west of Nantes.",
"French", "Oceanic climate", "The Loire Valley has a high density of vine plantings with an average of 1,600-2,000 vines per acre", "The Loire Valley wine region includes the French wine regions situated along the Loire River from the Muscadet region near the city of Nantes on the Atlantic coast to the region of Sancerre and Pouilly-Fume just southeast of the city of Orleans in north central France.");

INSERT INTO `WineType` (`TypeID`, `Type`) VALUES

("1", "Red Wine"),
("2", "White Wine"),
("3", "Rose Wine"),
("4", "Champagne"),
("5", "Sparkling Wine");

INSERT INTO `Suppliers` (`SupplierID`, `Supplier`) VALUES

("1", "Adega Vila Real"),
("2", "Adega de Moncao"),
("3", "Maison Sichel"),
("4", "Bordeaux/Bordeaux Superieur"),
("5", "Dourthe"),
("6", "Hunter's Wines"),
("7", "Spy Valley"),
("8", "Allegrini"),
("9", "Antonio Fattori"),
("10", "Camillo de Lellis"),
("11", "Bodegas Weinert"),
("12", "Dominio del Plata"),
("13", "55malbec"),
("14", "Jean-Marc and Julien Brocard"),
("15", "The Wine Gang"),
("16", "Pierre Gimonnet"),
("17", "Ruppertsberger Winzerverein"),
("18", "Reichsgraf von Kesselstatt"),
("19", "Boutinot"),
("20", "Painted Wolf Wines"),
("21", "Bougrier"),
("22", "Araldica Vini Piemontesi"),
("23", "Central Italy"),
("24", "Alovini"),
("25", "Contesa");

INSERT INTO `Wine` (`WineID`, `WoeID`, `RegionId`, `Name`, `TypeID`, `Alcohol`, `Colour`, `Description`, `Price`, `Image`, `Age`, `SupplierID`) VALUES

("1", "2", "0", "OLD VINES IN YOUNG HANDS BRANCO 2015", "2", "13.0", "White", "A fruity, rounded and excellent-value Portuguese white. Made from the fruit of old mixed-planted vineyards high in the Douro, where a younger generation is making its mark at the local co-operative.",
"5.75", "http://www.thewinesociety.com/resources/product_images/PW5771.jpg", "2", "1"),

("2", "2", "0", "OLD VINES IN YOUNG HANDS TINTO 2014", "1", "13.0", "Red", "From old vineyards high in the Douro Valley where a younger generation is making its mark at the local co-operative. The 2013 was a Society Wine Champion and we think this supple and fragrant new blend is delicious too.",
"5.75", "http://www.thewinesociety.com/resources/product_images/PW5521.jpg", "2", "1"),

("3", "2", "0", "THE SOCIETY'S VINHO VERDE 2015", "2", "11.5", "White", "2015 is a great vintage for this already fashionable region, making this an even more tempting buy. A traditional blend of alvarinho and trajadura, this is light-bodied, thoroughly refreshing and delicately spritzy on the palate.",
"5.95", "http://www.thewinesociety.com/resources/product_images/PW5581.jpg", "2", "2"),

("4", "1", "1", "HALF BOTTLE OF THE SOCIETY'S CLARET 2015", "1", "13.0", "Red", "A fruity and unoaked merlot-based claret, supplied for over quarter of a century by family-owned Maison Sichel.",
"3.95", "http://www.thewinesociety.com/resources/product_images/CL162.jpg", "1", "3"),

("5", "1", "1", "CHATEAU VAL DE BRIDOIRE, BORDEAUX 2014", "1", "13.0", "Red", "Simple, easy-drinking claret which shows that Bordeaux can still produce good, inexpensive wines with typicity and character. Fresh and savoury, made without the use of oak.",
"5.95", "http://www.thewinesociety.com/resources/product_images/Generic_Red2.jpg", "2", "4"),

("6", "1", "1", "DOURTHE NO 1 SAUVIGNON BLANC, BORDEAUX 2015", "2", "12.0", "White", "Dourthe are pioneers of modern Bordeaux sauvignon, blending from different soil types to achieve greater aromatic complexity and an attractive fresh, fruity palate.",
"8.5", "http://www.thewinesociety.com/resources/product_images/BW5491.jpg", "2", "5"),

("7", "3", "0", "RATA MARLBOROUGH SAUVIGNON BLANC 2016", "2", "12.5", "White", "New to our range, this Marlborough sauvignon blanc is wonderfully uncomplicated and deliciously refreshing. With an opulent tropical-fruit nose and ripe lemon and lime notes on the palate, this is a gorgeous dry crisp sauvignon blanc for anyday drinking.",
"6.95", "http://www.thewinesociety.com/resources/product_images/NZ9141.jpg", "2", "6"),

("8", "3", "0", "SPY VALLEY MARLBOROUGH SAUVIGNON BLANC 2016", "2", "13.0", "White", "2016 is looking like a great vibrant year for Marlborough sauvignon. This wonderfully aromatic example offers an intense perfume of citrus, gooseberry and tropical notes, which continue on the crisp, dry palate. A mouthwatering sauvignon, hugely enjoyable and highly recommended.",
"9.95", "http://www.thewinesociety.com/resources/product_images/NZ9191.jpg", "1", "7"),

("9", "3", "0", "SPY VALLEY MARLBOROUGH PINOT NOIR ROSE 2016", "3", "13.0", "Rose", "This delicate New Zealand rose is made from 100% pinot noir from Marlborough. Delicate pale pink in colour, with wild strawberries on the nose and plenty of summer-berry flavours on the palate, this is a dry and refreshing wine of great charm.",
"10.5", "http://www.thewinesociety.com/resources/product_images/NZ9101.jpg", "1", "7"),

("10", "4", "0", "HALF BOTTLE OF VALPOLICELLA ALLEGRINI 2015", "1", "13.0", "Red", "A cracking vintage here, showing exuberant fragrant fruit. Ripe, sweet, fresh and appetising, Allegrini's wine exhibits the fresh perfume and flavour of real Valpolicella in all its charm. A delight.",
"6.5", "http://www.thewinesociety.com/resources/product_images/Generic_Red2.jpg", "2", "8"),

("11", "4", "0", "PALLADIUM GARGANEGA VENETO 2016", "2", "12.5", "White", "Immediately appealing smiley Italian white for regular drinking, made from garganega, the Soave grape.",
"6.75", "http://www.thewinesociety.com/resources/product_images/IT22711.jpg", "1", "9"),

("12", "4", "0", "BIFERNO ROSSO RISERVA PALLADINO 2012", "1", "13.0", "Red", "A bold powerful Italian red with rustic warmth, good grip and a velvety palate after aging 18 months in large oak barrels. A blend of montepulciano, aglianico and trebbiano traditionally grown in Molise.",
"7.5", "http://www.thewinesociety.com/resources/product_images/IT23371.jpg", "4", "10"),

("13", "5", "0", "WEINERT CARRASCAL MENDOZA 2010", "1", "14.0", "Red", "Weinert's wines reflect the purity of their Argentine origins but with an unmistakeable nod to Europe, eschewing both high extraction and excessive oak. With rich dark fruit, velvety texture and mellow mature notes of cedar and leather, this blend of malbec, cabernet and merlot is on fine form indeed. This is made from a blend of 40% malbec, 35% cabernet sauvignon and 25% merlot aged two years in foudres and six months in vats before bottling.",
"9.5", "http://www.thewinesociety.com/resources/product_images/AR3371.jpg", "6", "11"),

("14", "5", "0", "FALDEOS NEVADOS MALBEC 2015", "1", "14.0", "Red", "Vivid blueberry and ground black pepper on the nose are joined by sweet rhubarb and blackcurrant. The perfect accompaniment to a good bit of griddled beef or full-flavoured sausages.",
"8.95", "http://www.thewinesociety.com/resources/product_images/AR3441.jpg", "2", "12"),

("15", "5", "0", "QUIMAY UCO VALLEY MALBEC 2014", "1", "13.5", "Red", "A very appealing Argentine malbec with a fresh, vibrant nose with a hint of oak, followed by a round and soft palate. Made from vines in Tunuyan and San Carlos.",
"9.95", "http://www.thewinesociety.com/resources/product_images/AR3611.jpg", "3", "13"),

("16", "1", "2", "HALF BOTTLE OF THE SOCIETY'S CHABLIS 2015", "2", "12.5", "White", "Ripe, full yet fresh Chablis. We blended three different components with Jean-Marc Brocard to produce a Chablis with good typicity.",
"7.25", "http://www.thewinesociety.com/resources/product_images/BU63222.jpg", "2", "14"),

("17", "1", "2", "EAN-MARC BROCARD, CHABLIS SAINTE-CLAIRE 2014", "2", "12.5", "White", "The Brocard house style is to age the wines in stainless steel to preserve their firm, taut and mineral character. This Chablis from the excellent 2014 vintage was matured on its lees for about 10 months to add a touch of roundness to the palate.",
"11.95", "http://www.thewinesociety.com/resources/product_images/BU63011.jpg", "3", "14"),

("18", "1", "2", "JEAN-MARC BROCARD, CHABLIS SAINTE-CLAIRE 2014", "2", "12.5", "White", "The Brocard house style is to age the wines in stainless steel to preserve their firm, taut and mineral character. This Chablis from the excellent 2014 vintage was matured on its lees for about 10 months to add a touch of roundness to the palate.",
"11.95", "http://www.thewinesociety.com/resources/product_images/BU63011.jpg", "3", "14"),

("19", "1", "3", "JEAN DE FOIGNY BRUT PREMIER CRU NV", "4", "12.5", "White", "A stylish and gentle premier cru Champagne, made for The Society by de Castelnau, a house that has been making Champagne for a century. The wine is a classic blend of 45% chardonnay, 35% pinot meunier and 20% pinot noir. Aged for over three years in bottle, this represents superb quality for the price.",
"19.5", "http://www.thewinesociety.com/resources/product_images/CH3381.jpg", "2", "15"),

("20", "1", "3", "PIERRE GIMONNET PREMIER CRU BRUT NV", "4", "12.5", "White", "The Gimonnet style is one of freshness, purity and intensity, and the fragrant, invigorating and racy non-vintage is a special wine. Instead of the usual stainless-steel tanks, the reserve wines for this blend are aged in bottle and then several vintages are chosen to be blended with a young wine. The result is something that has great complexity and mellowness yet also the freshness and vitality of young Champagne. A chilled glass served with a plate of oysters is simply divine.",
"24", "http://www.thewinesociety.com/resources/product_images/CH3151.jpg", "2", "16"),

("21", "6", "0", "THE SOCIETY'S RUPPERTSBERG 2015", "2", "12.5", "White", "A lovely, round-tasting, fresh and fruity white made from 60% silvaner and 40% riesling. This can be enjoyed in many ways, on its own or with food.",
"6.75", "http://www.thewinesociety.com/resources/product_images/GE9151.jpg", "1", "17"),

("22", "6", "0", "THE SOCIETY'S SAAR RIESLING 2014", "2", "9.5", "White", "Saar wines were successful in 2014. This fresh sappy riesling comes predominantly from von Kesselstatt's excellent Niedermenniger vineyard.",
"9.5", "http://www.thewinesociety.com/resources/product_images/GE8961.jpg", "2", "18"),

("23", "7", "0", "KAAP PLASS SAUVIGNON BLANC, WESTERN CAPE 2016", "2", "12.5", "White", "Fresh, lightly tropical-flavoured South African sauvignon, uncomplicated and easy to drink. Bottled in France.",
"5.75", "http://www.thewinesociety.com/resources/product_images/SA12171.jpg", "1", "19"),

("24", "7", "0", "PAINTED WOLF 'ROSALIND' PINOTAGE ROSE, PAARL 2016", "3", "13.5", "Rose", "Pinotage is better known as a red grape but, picked early to retain freshness, it lends itself well to making pale but toothsome rose, rather in the style of the French pinks from the Languedoc. The Wild Dog cub which adorns the label is a charming reminder of Painted Wolf's ongoing contribution to wildlife conservation in Africa.",
"7.5", "http://www.thewinesociety.com/resources/product_images/SA11591.jpg", "1", "20"),

("25", "1", "4", "VAL DE LOIRE SAUVIGNON BLANC, BOUGRIER 2015", "2", "12.0", "White", "Light, easy-drinking screwcapped IGP Val de Loire sauvignon, in the style of Touraine but at a more modest price.",
"5.95", "http://www.thewinesociety.com/resources/product_images/LO12921.jpg", "2", "21"),

("26", "1", "4", "ROSE D'ANJOU, FAMILLE BOUGRIER 2015", "3", "11.0", "Rose", "New presentation for the new vintage, but the same pretty pink colour and light and refreshing off-dry palate that has made this wine so popular. The sweetness here is not heavy, making it ideal on its own or with delicately flavoured Asian food. A blend of grolleau, gamay and cabernet franc.",
"6.95", "http://www.thewinesociety.com/resources/product_images/LO12181.jpg", "2", "21"),

("27", "4", "0", "PROSECCO BRUT I DUECENTO", "5", "11.5", "White", "Prosecco is all the rage at the moment, but there are some extremely poor examples knocking about. We took our time to source the right wine at the right price. It's fresh and gentle with a pleasing touch of green apples on the nose. A great, and great-value, party wine.",
"8.75", "http://www.thewinesociety.com/resources/product_images/IT20511.jpg", "2", "22"),

("28", "4", "0", "CHIANTI SANGERVASIO 2015", "1", "13.8", "Red", "Generous aromatic Chianti with fresh appetising cherry fruit made from healthy, ripe sangiovese grown in the hills between Florence and Pisa from where you can see the sea 25km away.",
"8.95", "http://www.thewinesociety.com/resources/product_images/IT22601.jpg", "2", "23"),

("29", "4", "0", "GRECO BASILICATA LE RALLE, ALOVINI 2015", "2", "13.0", "White", "Aromatic bouquet and spicy characterful flavour. Greco is a high-quality grape well suited to Basilicata's climate, and Oronzo Alo captures its fruit and flavour expertly.",
"9.25", "http://www.thewinesociety.com/resources/product_images/IT21741.jpg", "2", "24"),

("30", "4", "0", "PECORINO ABRUZZO, CONTESA 2015", "2", "13.0", "White", "Contesa means 'quarrel' in Italian, but our Wine Champions panel settled convivially on crowning this characterful Abruzzo white. Refreshingly dry and moreish, with a floral bouquet and lovely depth on the pure, orchard-fruited palate, this is a top-class example of this fashionable variety.",
"9.5", "http://www.thewinesociety.com/resources/product_images/IT21241.jpg", "2", "25");