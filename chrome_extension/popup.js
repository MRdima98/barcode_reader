document.addEventListener('click', function(e){
    var clickedElement = e.target;

    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", 'http://127.0.0.1:8000/', false ); 
    xmlHttp.setRequestHeader("X-PINGOTHER", "pingpong");
    xmlHttp.setRequestHeader("Content-Type", "text/xml");
    xmlHttp.send( null );

    console.log(xmlHttp.responseText);
    clickedElement.innerHTML = xmlHttp.responseText;
});
