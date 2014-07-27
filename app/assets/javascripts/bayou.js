var map,
	homePos,
	service, infoWindow, tooltip, infoBox,
	stores = [], hospitals = [],
	storesControl, 
	hospitalsControl,
	healthCentersControl,
	demoMode = true,
	alControl, flControl, laControl, msControl,
	clickedFeature,
	zoomLevel = 10,
	toggledStates = [],
	healthCenters = [];

function initialize() {
	var infoBox = document.getElementById('info-box'),
		mapContainer = document.getElementById('map-canvas'),
		mapOptions = {
			zoom: zoomLevel,
			center: new google.maps.LatLng(30.5, -89)
		};
	map = new google.maps.Map(mapContainer, mapOptions);

	infoWindow = new google.maps.InfoWindow();
	service = new google.maps.places.PlacesService(map);

	loadExtension();
	// if geolocation available, add home control:
	if(navigator.geolocation){
		var homeControlDiv = document.createElement('div');
		var homeControl = new Control(
			"Home", "Click to center the map around your location", 
			homeControlDiv, map, function(){
				getHomeLocation(demoMode);
			});
		homeControlDiv.index = 3;
		map.controls[google.maps.ControlPosition.TOP_RIGHT].push(homeControlDiv);
	}

	// add 'Toggle Nearby Stores' control:
	var storesControlDiv = document.createElement('div');
	storesControl = new Control(
		"Grocery/Produce", "Toggle Nearby Grocery and Produce",
		storesControlDiv, map, displayStores, clearStores);
	storesControl.toggleOpacity();
	storesControlDiv.index = 10;
	map.controls[google.maps.ControlPosition.TOP_RIGHT].push(storesControlDiv);

	// add 'Toggle Nearby Hospitals' control:
	var hospitalsControlDiv = document.createElement('div');
	hospitalsControl = new Control(
		"Hospitals", "Toggle Nearby Hospitals",
		hospitalsControlDiv, map, displayHospitals, clearHospitals);
	hospitalsControl.toggleOpacity();
	hospitalsControlDiv.index = 10;
	map.controls[google.maps.ControlPosition.TOP_RIGHT].push(hospitalsControlDiv);

	// add 'Toggle Health Centers' control:
	var healthCentersControlDiv = document.createElement('div');
	healthCentersControl = new Control(
		"Health Centers", "Toggle Health Centers",
		healthCentersControlDiv, map, handleHealthCenters, clearHealthCenters);
	healthCentersControl.toggleOpacity();
	healthCentersControlDiv.index = 10;
	map.controls[google.maps.ControlPosition.TOP_RIGHT].push(healthCentersControlDiv);

	// Load Tract GeoJSON data:
	// map.data.loadGeoJson('/map_layers/1.json');

	// add 'Show Alabama' control:
	var alControlDiv = document.createElement('div');
	alControl = new Control(
		"AL", "Click to toggle Alabama Census Tracts",
		alControlDiv, map, function(){
			displayCensusTracts('al');
		}, function(){
			clearCensusTracts('al');
		});
	alControl.toggleOpacity();
	alControlDiv.index = 10;
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(alControlDiv);

	// add 'Show Florida' control:
	var flControlDiv = document.createElement('div');
	flControl = new Control(
		"FL", "Click to Toggle Florida Census Tracts",
		flControlDiv, map, function(){
			displayCensusTracts('fl');
		}, function(){
			clearCensusTracts('fl');
		});
	flControl.toggleOpacity();
	flControlDiv.index = 10;
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(flControlDiv);

	// add 'Show Louisiana' control:
	var laControlDiv = document.createElement('div');
	laControl = new Control(
		"LA", "Click to Toggle Louisana Census Tracts",
		laControlDiv, map, function(){
			displayCensusTracts('la');
		}, function(){
			clearCensusTracts('la');
		});
	laControl.toggleOpacity();
	laControlDiv.index = 10;
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(laControlDiv);

	// add 'Show Mississippi' control:
	var msControlDiv = document.createElement('div');
	msControl = new Control(
		"MS", "Click to Toggle Mississippi",
		msControlDiv, map, function(){
			displayCensusTracts('ms');
		}, function(){
			clearCensusTracts('ms');
		});
	msControl.toggleOpacity();
	msControlDiv.index = 10;
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(msControlDiv);

	map.data.addListener('mouseover', function(event) {
		var some_lat = event.feature.getProperty('center').lat
		var some_lng = event.feature.getProperty('center').lng
		var county = event.feature.getProperty('county');
		var state = event.feature.getProperty('state');
		var lalits = event.feature.getProperty('lalits') * 100;
		var distance = event.feature.getProperty('distance');

		infoBox.innerHTML = county + ", " + state + ":<br>" 
			+ lalits.toFixed(2) + "% live more than " 
				+ distance + " miles from fresh food.";

		// if (infoWindow) {
		// 	infoWindow.close();
		// }
		// infoWindow = new google.maps.InfoWindow({
		// 	position: new google.maps.LatLng(some_lng, some_lat),
		// 	content: event.feature.getProperty('lalits')*100 + "% live more than " 
		// 		+ event.feature.getProperty('distance') + " miles from fresh food."
		// });
		// infoWindow.open(map);
	});
	map.data.addListener('click', function(event) {
		displayStores(event.feature.getProperty("sw"), event.feature.getProperty("ne"));
		displayHospitals(event.feature.getProperty("sw"), event.feature.getProperty("ne"));
		clickedFeature = event.feature;
	});

	// enable LA tracts:
	msControl.toggle();
	// enable health centers:
	healthCentersControl.toggle();
}

google.maps.event.addDomListener(window, 'load', initialize);

function displayCensusTracts(state){
	$.getJSON('map_layers/'+state+'.json', function(features){
		// add state features to the control so they can be removed later:
		window[state+"Control"].toggables = map.data.addGeoJson(features);
	});

	toggledStates.push(state.toUpperCase());
	displayHealthCenters();

	map.data.setStyle(function(feature) {
		var lalits = feature.getProperty('lalits');
		var R  = 'FF';
		var GB = 'FFFF';
		if (lalits < .05){
			GB = 'DDDD';
		} else if (lalits < .10){
			GB = 'BBBB';
		} else if (lalits < .15){
			GB = 'AAAA';
		} else if (lalits < .20){
			GB = '8888';
		} else if (lalits < .25){
			GB = '6666';
		} else if (lalits < .30){
			GB = '4444';
		} else if (lalits < .35){
			GB = '2222';
		} else if (lalits < .40){
			GB = '0000';
		} else if (lalits < .45){
			GB = '0000'; R = 'EE';
		} else if (lalits < .50){
			GB = '5555'; R = 'DD';
		} else if (lalits < .55){
			GB = '4444'; R = 'CC';
		} else if (lalits < .60){
			GB = '3333'; R = 'BB';
		} else if (lalits < .65){
			GB = '2222'; R = 'AA';
		} else if (lalits < .70){
			GB = '1111'; R = 'AA';
		} else if (lalits < .75){
			GB = '0000'; R = 'AA';
		}
		var rgb = '#' + R + GB;
		return {
			fillColor: rgb,
			fillOpacity: 0.8,
			strokeWeight: 0.5,
			clickable: true
		};
	});
	
	map.data.addListener('mouseover', function(event) {
		// document.getElementById('info-box').textContent = event.feature.getProperty('lalits') + "% of people are at least " + event.feature.getProperty('distance') + " miles away.";
		//console.log('moused over!');
	});
	map.data.addListener('click', function(event) {
		var sw = event.feature.getProperty("sw");
		var ne = event.feature.getProperty("ne");
		displayStores(sw, ne);
		displayHospitals(sw, ne);
	});
}

function clearCensusTracts(state){
	var features = window[state+"Control"].toggables;
	for(var i=0; i<features.length; i++){
		map.data.remove(features[i]);
	}
	toggledStates.splice(toggledStates.indexOf(state), 1);
	clearHealthCenters();
}

function handleHealthCenters(){
	if(healthCenters.length === 0){
		$.getJSON('http://localhost:3000/health_centers.json', function(centers){
			healthCenters = centers;
			console.log("Req came back");
			displayHealthCenters();
		});
	} else {
		displayHealthCenters();
	}

}

function displayHealthCenters(){
	for(var i = 0, 
		toggables = healthCentersControl.toggables,
		numCenters = healthCenters.length; i < numCenters; i++){
		if(toggledStates.indexOf(healthCenters[i]["ARC_State"]) > -1)
			toggables.push(createMarker(healthCenters[i], "assets/hcenter.png"));
	}
	console.log(healthCentersControl.toggables);
}

function clearHealthCenters(){
	for(var i = 0, 
			toggables = healthCentersControl.toggables,
			numCenters = toggables.length; i < numCenters; i++){
		console.log(toggables[i]["ARC_State"]);
		if(toggledStates.indexOf(toggables[i]["ARC_State"]) == -1)
			toggables[i].setMap(null);
	}
	toggables = [];
}

// displays stores, based on given sw/ne 
// or global viewport bounds:
function displayStores(sw, ne){
	if(storesControl.isOn){
		clearStores();
		var request = {
			bounds: ((sw && ne) 
				? new google.maps.LatLngBounds(
					new google.maps.LatLng(sw.lat, sw.lng), 
					new google.maps.LatLng(ne.lat, ne.lng))
				: map.getBounds()),
			keyword: 'grocery',
		};
		service.radarSearch(request, processStoreJSON);
	}
}

function clearStores(){
	for(var i=0; i<storesControl.toggables.length; i++){
		storesControl.toggables[i].setMap(null);
	}
	storesControl.toggables = [];
}

function processStoreJSON(results, status) {
	if (status != google.maps.places.PlacesServiceStatus.OK) {
		//alert(status);
		return;
	}
	for (var i = 0; clickedFeature && i < results.length; i++) {
		var poly = new google.maps.Polygon({ paths: getPathsFromFeature(clickedFeature) });
		if(poly.containsLatLng(results[i].geometry.location.lat(), results[i].geometry.location.lng())){
			storesControl.toggables.push(createMarker(results[i], "assets/reddot.png"));
		}
	}
}

// takes a feature and extracts it's array of "paths" (arrays of lat/lng pairs)
// that can be used to construct Polygons.
function getPathsFromFeature(feature){
	var rawPaths = feature['k']['Z'], 
		paths = [];
	for(var p = 0; p < rawPaths.length; p++){
		paths.push(rawPaths[p]['Z']);
	}
	return paths;
}

function displayHospitals(sw, ne){
	if(hospitalsControl.isOn){
		clearHospitals();
		var request = {
			bounds: ((sw && ne) 
				? new google.maps.LatLngBounds(
					new google.maps.LatLng(sw.lat, sw.lng), 
					new google.maps.LatLng(ne.lat, ne.lng))
				: map.getBounds()),
			keyword: 'hospital',
		};
		service.radarSearch(request, processHospitalJSON);
	}
}

function clearHospitals(){
	for(var i=0; i<hospitalsControl.toggables.length; i++){
		hospitalsControl.toggables[i].setMap(null);
	}
	hospitalsControl.toggables = [];
}

function processHospitalJSON(results, status) {
	if (status != google.maps.places.PlacesServiceStatus.OK) {
		//alert(status);
		return;
	}
	for (var i = 0; clickedFeature && i < results.length; i++) {
		var poly = new google.maps.Polygon({ paths: getPathsFromFeature(clickedFeature) });
		if(poly.containsLatLng(results[i].geometry.location.lat(), results[i].geometry.location.lng())){
			storesControl.toggables.push(createMarker(results[i], "assets/bluedot.png"));
		}
	}
}

function createMarker(place, iconPath) {
	// Build the marker, determining if place is a Google Places API object,
	// or a Health Center from our database:
	var isGooglePlace = place.hasOwnProperty("geometry");
	var marker = new google.maps.Marker({
		map: map,
		position: isGooglePlace ?
							place.geometry.location
							: 
							new google.maps.LatLng(place["Y"], place["X"]),
		icon : iconPath
	});
	if(!isGooglePlace){
		marker["ARC_State"] = place["ARC_State"];
	}
	google.maps.event.addListener(marker, 'click', function() {
		if(isGooglePlace) {
			service.getDetails(place, function(result, status) {
				if (status != google.maps.places.PlacesServiceStatus.OK) {
					//alert(status);
					return;
				}
				
				infoWindow.setContent(result.name);
				infoWindow.open(map, marker);
			});
		} else {	// must be health center:
			var content = "<h3>" + place["Name"] + "</h3>" +
							"<p>Address: " + place["Match_addr"] + "</p>" +
							"<p>Operator: " + place["Operator"] + "</p>" +
							"<p>Status: " + place["Status_1"] + "</p>";
			infoWindow.setContent(content);
			infoWindow.open(map, marker);
		}
	});
	console.log(marker);
	return marker;
}

// attempts to retrieve user's home location:
function getHomeLocation(demoMode){
	if(demoMode)
		homePos = new google.maps.LatLng(29.5, -89);
	else if(!homePos){
		navigator.geolocation.getCurrentPosition(function(position) {
			homePos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
			map.setCenter(homePos);
		}, function() {
			handleNoGeolocation(true);
		});
	} else {
		map.setCenter(homePos);
	}
}

function handleNoGeolocation(errorFlag) {
	if (errorFlag) {
		var content = 'Error: The Geolocation service failed.';
	} else {
		var content = 'Error: Your browser doesn\'t support geolocation.';
	}

	var options = {
		map: map,
		position: new google.maps.LatLng(30, -89),
		content: content
	};

	var infowindow = new google.maps.InfoWindow(options);
	map.setCenter(options.position);
}

// A constructor for custom map controls:
function Control(label, title, controlDiv, map, onHandler, offHandler){
	var control = this;
	control.toggables = [];		// collection of objects which will be toggled by this control
	control.isOn = false;		// tracks whether this control is on/off

	controlDiv.style.padding = '5px';

	control.controlUI = document.createElement('div');
	control.controlUI.style.backgroundColor = '#00d2ff';
	control.controlUI.style.borderStyle = 'solid';
	control.controlUI.style.borderWidth = '.5px';
	control.controlUI.style.cursor = 'pointer';
	control.controlUI.style.textAlign = 'center';
	control.controlUI.style.opacity = 1;
	control.controlUI.title = title;
	controlDiv.appendChild(control.controlUI);

	// Set CSS for the control interior.
	var controlText = document.createElement('div');
	controlText.style.fontFamily = 'Arial,sans-serif';
	controlText.style.fontSize = '16px';
	controlText.style.color = 'white';
	controlText.style.paddingLeft = '15px';
	controlText.style.paddingRight = '15px';
	controlText.style.paddingTop = '7px';
	controlText.style.paddingBottom = '7px';
	controlText.innerHTML = '<strong>'+label+'</strong>';
	control.controlUI.appendChild(controlText);

	control.toggleOpacity = function(){
		if(control.controlUI.style.opacity == 1)
			control.controlUI.style.opacity = .3;
		else 
			control.controlUI.style.opacity = 1;
	}

	control.toggle = function(){
		control.toggleOpacity();
		if(control.isOn){
			control.isOn = false;
			offHandler();
		} else {
			control.isOn = true;
			onHandler();
		}
	}
	// Setup the click event listener:
	google.maps.event.addDomListener(control.controlUI, 'click', control.toggle);
}
