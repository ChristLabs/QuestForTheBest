async function getMapData(){
    const response = await fetch("https://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetMapData");
    const data = await response.json();
    
    return renderMap(data);
}



function renderMap(mapData){
	var map = L.map("mapDiv").setView([47.0455, -122.8989], 16);

	L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
		maxZoom: 19,
		attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
	}).addTo(map);
	
	mapData.forEach((data) => {
        L.marker([data.latitude, data.longitude]).addTo(map)
			.bindTooltip(`${data.barName}<br />
							Average Score: ${data.averageScore}<br />
							Best Cocktail: ${data.bestCocktail}<br />
							Times Visited: ${data.timesVisited}`);
    });
}

getMapData();