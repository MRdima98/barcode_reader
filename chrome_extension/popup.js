const socket = new WebSocket("ws://localhost:8000/ws");

socket.onopen = function(event) {
  console.log("WebSocket connection established.");
  socket.send("Hello from the extension!");
};

socket.onmessage = function(event) {
  const message = event.data;
  console.log("Message received from the server: ", message);
};

socket.onclose = function(event) {
  console.log("WebSocket connection closed.");
};

socket.onerror = function(error) {
  console.error("WebSocket error:", error);
};

document.addEventListener('click', function(e){
    var clickedElement = e.target;

    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", 'http://127.0.0.1:8000/', false ); 
    xmlHttp.send( null );

    console.log(xmlHttp.responseText);
    clickedElement.innerHTML = xmlHttp.responseText;
});
