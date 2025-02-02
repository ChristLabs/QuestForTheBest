


async function getQuests(){
    const response = await fetch("http://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetQuests");
    const data = await response.json();
    
    data.forEach((quest) => {
        document.getElementById("quest-card-container").insertAdjacentHTML("beforeend", renderQuestCard(quest));
    });
}

getQuests();

function renderQuestCard(quest) {
    var cocktailNameNoSpaces = quest.cocktailName.replace(/\s/g, '');
    var date = new Date(quest.dateOfQuest);
    return `<div class="col">
				<a href="${cocktailNameNoSpaces}.html" class="text-decoration-none">
					<div class="card h-100 text-center p-3">
						<img src="Content/Images/${cocktailNameNoSpaces}_card.webp" class="card-img-top" alt="${quest.cocktailName} Cocktail">
						<div class="card-body">
							<h5 class="card-title">${quest.cocktailName}</h5>
                            <p class="text-center fst-italic">${date.toLocaleDateString()}</p>
							<p class="card-text">${quest.cocktailDescription}</p>
						</div>
					</div>
				</a>
			</div>`;
}