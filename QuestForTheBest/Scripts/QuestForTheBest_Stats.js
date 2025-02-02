
function getStats(){
	getTotalScores();
	getScoresByCocktail();
	getScoresByQuester();
	getScoresByBar();
}

getStats();

async function getTotalScores(){
    const response = await fetch("http://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetTotalScores");
    const data = await response.json();
    
    document.getElementById("lblTotalScores").innerHTML = data;
}

async function getScoresByCocktail(){
    const response = await fetch("http://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetScoresByCocktail");
    const data = await response.json();
    
    data.forEach((stat) => {
		document.getElementById("tblScoresByCocktail").insertAdjacentHTML("beforeend", `<tr><td>${stat.cocktailName}</td><td>${stat.averageScore}</td></tr>`)
    });
}

async function getScoresByQuester(){
    const response = await fetch("http://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetScoresByQuester");
    const data = await response.json();
    
    data.forEach((stat) => {
		document.getElementById("tblScoresByQuester").insertAdjacentHTML("beforeend", `<tr><td>${stat.questerName}</td><td>${stat.averageScore}</td><td>${stat.cocktailsDrank}</td></tr>`)
    });
}

async function getScoresByBar(){
    const response = await fetch("http://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetScoresByBar");
    const data = await response.json();
    
    data.forEach((stat) => {
		document.getElementById("tblScoresByBar").insertAdjacentHTML("beforeend", `<tr><td>${stat.barName}</td><td>${stat.averageScore}</td><td>${stat.timesVisited}</td></tr>`)
    });
}
