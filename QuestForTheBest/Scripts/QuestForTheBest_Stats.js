
function getStats(){
	getTotalScores();
	getHighestScores();
	getHighestCocktailScores();
	getScoresByCocktail();
	getScoresByQuester();
	getScoresByBar();
}

getStats();

async function getTotalScores(){
  const response = await fetch("https://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetTotalScores");
  const data = await response.json();
  
  document.getElementById("lblTotalScores").innerHTML = data;
}

async function getHighestScores(){
    const response = await fetch("https://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetHighestScores");
    const data = await response.json();
    
    data.forEach((stat) => {
		  document.getElementById("tblHighestScores").insertAdjacentHTML("beforeend", `<tr><td>${stat.questerName}</td><td>${stat.score}</td><td>${stat.cocktailName}</td><td>${stat.barName}</td><td>${new Date(stat.dateOfQuest).toLocaleDateString()}</td></tr>`)
    });
}

async function getHighestCocktailScores(){
    const response = await fetch("https://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetHighestCocktailScores");
    const data = await response.json();
    
    data.forEach((stat) => {
		  document.getElementById("tblHighestCocktailScores").insertAdjacentHTML("beforeend", `<tr><td>${stat.cocktailName}</td><td>${stat.barName}</td><td>${stat.averageScore}</td></tr>`)
    });
}

async function getScoresByCocktail(){
    const response = await fetch("https://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetScoresByCocktail");
    const data = await response.json();
    
    data.forEach((stat) => {
		  document.getElementById("tblScoresByCocktail").insertAdjacentHTML("beforeend", `<tr><td>${stat.cocktailName}</td><td>${stat.averageScore}</td></tr>`)
    });
}

async function getScoresByQuester(){
    const response = await fetch("https://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetScoresByQuester");
    const data = await response.json();
    
    data.forEach((stat) => {
		  document.getElementById("tblScoresByQuester").insertAdjacentHTML("beforeend", `<tr><td>${stat.questerName}</td><td>${stat.averageScore}</td><td>${stat.cocktailsDrank}</td></tr>`)
    });
}

async function getScoresByBar(){
    const response = await fetch("https://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetScoresByBar");
    const data = await response.json();
    
    data.forEach((stat) => {
		  document.getElementById("tblScoresByBar").insertAdjacentHTML("beforeend", `<tr><td>${stat.barName}</td><td>${stat.averageScore}</td><td>${stat.timesVisited}</td><td>${stat.cocktailsDrank}</td></tr>`)
    });
}
