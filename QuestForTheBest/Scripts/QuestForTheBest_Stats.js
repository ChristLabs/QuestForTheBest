
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

//#region sort
(function () {
	function getCellValue(tr, idx) {
		const cell = tr.children[idx];
		return (cell ? cell.textContent : "").trim();
	}

	function detectType(values) {
		// Try date (Date.parse), then number, else text
		const nonEmpty = values.filter(v => v !== "");
		if (nonEmpty.length === 0) return "text";

		const dateLike = nonEmpty.every(v => !isNaN(Date.parse(v)));
		if (dateLike) return "date";

		const numberLike = nonEmpty.every(v => {
			const n = parseFloat(v.replace(/[^0-9.\-]/g, ""));
			return !isNaN(n);
		});
		if (numberLike) return "number";

		return "text";
	}

	function compare(a, b, type, dir) {
		if (type === "number") {
			const na = parseFloat(a.replace(/[^0-9.\-]/g, ""));
			const nb = parseFloat(b.replace(/[^0-9.\-]/g, ""));
			return (na - nb) * dir;
		}

		if (type === "date") {
			const da = Date.parse(a);
			const db = Date.parse(b);
			return (da - db) * dir;
		}

		// text
		return a.localeCompare(b, undefined, { numeric: true, sensitivity: "base" }) * dir;
	}

	function makeSortable(table) {
		const thead = table.tHead;
		const tbody = table.tBodies[0];
		if (!thead || !tbody) return;

		const headers = Array.from(thead.rows[0].cells);

		headers.forEach((th, idx) => {
			th.style.cursor = "pointer";
			th.title = th.title || "Click to sort";

			th.addEventListener("click", () => {
				const rows = Array.from(tbody.rows);

				// toggle direction per column
				const current = th.getAttribute("data-sort-dir");
				const dir = current === "asc" ? -1 : 1; // 1=asc, -1=desc

				// clear other headers
				headers.forEach(h => h.removeAttribute("data-sort-dir"));
				th.setAttribute("data-sort-dir", dir === 1 ? "asc" : "desc");

				const sampleValues = rows.map(r => getCellValue(r, idx));
				const type = detectType(sampleValues);

				rows.sort((ra, rb) => {
					const a = getCellValue(ra, idx);
					const b = getCellValue(rb, idx);
					return compare(a, b, type, dir);
				});

				// re-append in sorted order
				const frag = document.createDocumentFragment();
				rows.forEach(r => frag.appendChild(r));
				tbody.appendChild(frag);
			});
		});
	}

	// Use a selector to pick which tables become sortable:
	// Example: add class="js-sort" to your tables.
	document.addEventListener("DOMContentLoaded", () => {
		document.querySelectorAll("table.js-sort").forEach(makeSortable);
	});
})();
//#endregion