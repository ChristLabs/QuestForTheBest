
function bindSearch() {
	const input = document.getElementById('nameFilter');
	const clearBtn = document.getElementById('clearFilter');
	const cards = Array.from(document.querySelectorAll('.flip-card'));

	function normalize(s) {
		return (s || '').toLowerCase().trim();
	}

	function applyFilter() {
		const q = normalize(input.value);

		cards.forEach((card) => {
			const nameEl = card.querySelector('.flip-card-front .h5');
			const name = normalize(nameEl ? nameEl.textContent : '');
			const show = !q || name.includes(q);

			// hide the Bootstrap column that contains the card
			const col = card.closest('.col');
			if (col) col.classList.toggle('d-none', !show);
		});
	}

	input.addEventListener('input', applyFilter);
	clearBtn.addEventListener('click', () => {
		input.value = '';
		input.focus();
		applyFilter();
	});
};

async function getAboutUs(){
    const response = await fetch("https://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetAboutUs");
    const data = await response.json();
    
    data.forEach((quester) => {
        document.getElementById("about-us-card-container").insertAdjacentHTML("beforeend", renderAboutUsCard(quester));
    });
	bindSearch();
}

getAboutUs();

function renderAboutUsCard(quester) {
    //var cocktailNameNoSpaces = quest.cocktailName.replace(/\s/g, '');

    return `<div class="col">
				<div class="flip-card">
					<div class="flip-card-inner">
						<div class="flip-card-front">
							<div class="avatar mb-3">${quester.questerNickname[0]}</div>
							<div class="h5 mb-1">${quester.questerNickname}</div>
						</div>
						<div class="flip-card-back">
							<div class="h6 mb-2">${quester.questerName}</div>
							<div class="stat-line"><span>Average score</span><strong>${quester.overallAverageScore}</strong></div>
							<div class="stat-line"><span>Total ratings</span><strong>${quester.totalScoresGiven}</strong></div>
							<div class="stat-line"><span>Top bar</span><strong>${quester.favoriteBar}(${quester.averageBarScore})</strong></div>
							<div class="stat-line"><span>Favorite Cocktail</span><strong>${quester.favoriteCocktail}(${quester.averageCocktailScore})</strong></div>
						</div>
					</div>
				</div>
			</div>`;
}