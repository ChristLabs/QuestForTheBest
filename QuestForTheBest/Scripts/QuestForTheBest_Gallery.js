var imageUrls = [
    "Margarita_card.webp",
    "MoscowMule_banner.webp",
    "MaiTai_card.webp",
    "WhiskeySour_card.webp",
    "Manhattan_card.webp",
    "HotToddy_banner.webp",
    "Clementines.jpg",
    "CockStats_banner.jpg",
    "CocktailBanner.webp",
    "manhattan1.jpg",
    "manhattan2.jpg",
    "manhattan4.jpg",
    "manhattan5.jpg",
    "manhattan6.jpg",
    "manhattan7.jpg",
    "manhattan8.jpg",
];

function randomizeImageOrder(){
    for (let i = imageUrls.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        const temp = imageUrls[i];
        imageUrls[i] = imageUrls[j];
        imageUrls[j] = temp;
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

    imageUrls.forEach((image) => {
        document.getElementById("imageContainer").insertAdjacentHTML("beforeend", `
            <div class="grid-item" onclick="showGalleryModal(event);">
					<img src="Content/Images/Gallery/${image}" class="img-fluid" />
            </div>`)
    });

    initMasonry();
}

renderImages();

function showGalleryModal(event){
    var imageUrl = event.currentTarget.querySelector("img").src;

    document.getElementById("galleryModalImg").src = imageUrl;

    var galleryModal = new bootstrap.Modal(document.getElementById("galleryModal"))
    galleryModal.show();
}

