


async function getQuests(){
    const response = await fetch("https://www.christlabs.dev/QuestForTheBest/api/QuestForTheBest/GetQuests");
    const data = await response.json();
    
    data.forEach((quest) => {
        document.getElementById("quest-card-container").insertAdjacentHTML("beforeend", renderQuestCard(quest));
    });
}

//getQuests();

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

function renderImagesFromFolder(folderPath) {
	// Get the image container element 
	const imageContainer = document.getElementById("quest-card-container");
  
	// Fetch the list of images from the folder
	fetch(folderPath)
	  .then(response => response.text())
	  .then(text => {
		const parser = new DOMParser();
		const htmlDoc = parser.parseFromString(text, "text/html");
		const imageFiles = Array.from(htmlDoc.querySelectorAll("a"))
		  .filter(link => link.href.endsWith(".jpg") || link.href.endsWith(".png") || link.href.endsWith(".webp"))
		  .map(link => link.href);
  
		// Create image elements for each image and append to the container
		imageFiles.forEach(imageFile => {
		  imageContainer.insertAdjacentHTML("beforeend", `<div class="col"><a href="Margarita.html" class="text-decoration-none"><div class="card h-100 text-center"><img src="${imageFile}" class="card-img-top" alt="Image from folder"></div></a></div>`);
		});
	  })
	  .catch(error => console.error("Error fetching images:", error));
  }
  
  // Example usage
  renderImagesFromFolder('/Content/Images/');