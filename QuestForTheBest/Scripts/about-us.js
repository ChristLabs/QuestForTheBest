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
			const nickEl = card.querySelector('.flip-card-front .h5'); // nickname
			const nameEl = card.querySelector('.flip-card-back .h6');  // full name

			const nick = normalize(nickEl ? nickEl.textContent : '');
			const name = normalize(nameEl ? nameEl.textContent : '');

			const show = !q || nick.includes(q) || name.includes(q);

			const col = card.closest('.col');
			if (col) col.classList.toggle('d-none', !show);
		});
	}

	input.addEventListener('input', applyFilter);

	if (clearBtn) {
		clearBtn.addEventListener('click', () => {
			input.value = '';
			input.focus();
			applyFilter();
		});
	}

	applyFilter(); // run once on load
}

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

	var imageUrl = quester.questName

    return `<div class="col">
				<div class="flip-card">
					<div class="flip-card-inner">
						<div class="flip-card-front">
							<div class="profile-wrap mb-3">
								<img
									class="profile-img"
									src="${(() => {
										const parts = quester.questerName.trim().split(' ');
										const firstInitial = parts[0][0];
										const lastName = parts[parts.length - 1];
										return `Content/Images/Drinkers/${lastName}${firstInitial}.jpg`;
									})()}"
									alt="${quester.questerNickname}"
									loading="lazy"
									onerror="this.remove(); this.parentElement.classList.add('no-img');" />
								<div class="profile-fallback">${quester.questerNickname[0]}</div>
							</div>

							<div class="h5 mb-1">${quester.questerNickname}</div>
							<div class="muted">Highest Score: ${quester.highestScore}</div>
							<div class="muted">${quester.highestScoreCocktail} at ${quester.highestScoreBar}</div>
						</div>

						<div class="flip-card-back">
							<div class="h6 mb-2">${quester.questerName}</div>
							<div class="stat-line"><span>Quests Attended</span><strong>${quester.questsAttended}</strong></div>
							<div class="stat-line"><span>Average score</span><strong>${quester.overallAverageScore}</strong></div>
							<div class="stat-line"><span>Drinks drank</span><strong>${quester.totalScoresGiven}</strong></div>
							<div class="stat-line no-cut"><span>Top bar</span><strong>${quester.favoriteBar} (${quester.averageBarScore})</strong></div>
							<div class="stat-line no-cut"><span>Favorite Cocktail</span><strong>${quester.favoriteCocktail} (${quester.averageCocktailScore})</strong></div>
						</div>
					</div>
				</div>
			</div>`;
}