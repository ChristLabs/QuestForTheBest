
function getStats(){
	getTotalScores();
	getHighestScores();
	getQuestWinners();
    getDrunkestGuy();
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

async function getQuestWinners(){
    const response = await fetch("https://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetQuestWinners");
    const data = await response.json();
    
    renderQuestWinnersHeroDisplay(data);
	
	data.sort((a, b) => {		
		return new Date(b.dateOfQuest) - new Date(a.dateOfQuest);
	});

	data.forEach((stat) => {
		  document.getElementById("tblQuestWinners").insertAdjacentHTML("beforeend", `<tr><td>${stat.cocktailName}</td><td>${stat.barName}</td><td>${stat.averageScore}</td><td>${new Date(stat.dateOfQuest).toLocaleDateString()}</td></tr>`)
    });
}

function renderQuestWinnersHeroDisplay(data){
    //-- Get last 3 quest winners
    for(let i = data.length - 1; i > data.length - 4; i--){
        document.getElementById("quest-winners-row").insertAdjacentHTML("beforeend", `
            <div class="col-lg-4">
                <div class="card mb-lg-0 mb-3">
                    <div class="card-body card-background" style="background-image: url('Content/Images/${data[i].cocktailName.replace(/\s+/g, '')}_card.webp');">
                        <div class="darken-overlay"></div>
                        <div class="position-relative text-center">
                            <h4 class="card-title text-uppercase m-0">${data[i].barName}</h4>
                            <h6 class="card-title text-uppercase m-0">${data[i].cocktailName}</h6>
                            <h2 class="display-2 mb-0">${data[i].averageScore}</h2>
                            <p class="card-text text-uppercase">Average Score</p>
                            <a href="${data[i].cocktailName.replace(/\s+/g, '')}.html" class="btn btn-outline-primary btn-sm text-uppercase">View quest</a>
                        </div>
                    </div>
                </div>
            </div>
        `);
    }
}

async function getDrunkestGuy(){
    const response = await fetch("https://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetDrunkestGuy");
    const data = await response.json();

    let questerImageName = data.questerName.split()

    document.getElementById("drunkest-guy-card").innerHTML = `
        <h3 class="text-uppercase mt-0 mb-4">Drunkest Guy</h3>
        <img id="drunkest-img" class="img-fluid d-block rounded mb-4" src="Content/Images/Drinkers/${getLastNameFirstInitial(data.questerName)}.jpg" />
        <h2 class="text-uppercase m-0">${data.questerNickname}</h2>
        <h5 class="text-uppercase m-0">${data.questerScoreCount} Drinks</h5>
        <h5 class="text-uppercase m-0">${data.percentageOfTotal}% of total</h5>
    `;
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


function getLastNameFirstInitial(fullName) {
    const [firstName, lastName] = fullName.trim().split(' ');
    if (!firstName || !lastName) return 'Invalid input';
    return `${lastName}${firstName.charAt(0)}`;
}