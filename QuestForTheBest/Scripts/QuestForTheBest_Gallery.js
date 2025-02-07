function randomizeImageOrder(){
    for (let i = imageData.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        const temp = imageData[i];
        imageData[i] = imageData[j];
        imageData[j] = temp;
    }
}

function initMasonry(){
    var grid = document.querySelector('.grid');
    var msnry;

    imagesLoaded( grid, function() {
        // init Isotope after all images have loaded
        msnry = new Masonry( grid, {
            itemSelector: '.grid-item',
            columnWidth: '.grid-sizer',
            percentPosition: true,
            gutter: 10
        });
    });
}

function renderImages(){
    randomizeImageOrder();

    imageData.forEach((image) => {
        document.getElementById("imageContainer").insertAdjacentHTML("beforeend", `
            <div class="grid-item" onclick="showGalleryModal(event);">
					<img src="Content/Images/Gallery/${image.fileName}" alt="${image.altText}" class="img-fluid" />
            </div>`)
    });

    initMasonry();
}

renderImages();

function showGalleryModal(event){
    var imageUrl = event.currentTarget.querySelector("img").src;
    var altText = event.currentTarget.querySelector("img").alt;

    document.getElementById("galleryModalImg").src = imageUrl;
    document.getElementById("galleryModalTitle").innerText = altText;

    var galleryModal = new bootstrap.Modal(document.getElementById("galleryModal"))
    galleryModal.show();
}

