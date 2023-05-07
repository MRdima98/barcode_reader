document.addEventListener('click', function(e){
    var clickedElement = e.target;
    clickedElement.innerHTML = "Hello";
    console.log(clickedElement);
});
