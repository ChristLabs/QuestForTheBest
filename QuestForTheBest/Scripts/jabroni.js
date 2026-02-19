document.addEventListener("DOMContentLoaded", function () {

		const jabroniChance = 0.15; // 10% chance (change to taste)

		const options = ["Jabroni", "Nigiri", "Baloney", "Crebroni", "Macaroni", "Rigatoni", "Pepperoni", "Zamboni"];

		document.querySelectorAll(".jabroni").forEach(el => {

			if (Math.random() < jabroniChance) {

				const replacement = options[Math.floor(Math.random() * options.length)];

				// Replace only the word "Negroni" inside this element
				el.innerHTML = el.innerHTML.replaceAll("Negroni", replacement);

			}

		});

	});