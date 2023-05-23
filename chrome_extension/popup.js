const socket = new WebSocket("ws://localhost:8000/ws");
let clickedElement;

socket.onopen = function(event) {
  console.log("WebSocket connection established.");
  socket.send("Hello from the extension!");
};

socket.onmessage = function(event) {
  clickedElement.innerHTML = event.data;
  console.log("Message received from the server: ", event.data);
};

socket.onclose = function(event) {
  console.log("WebSocket connection closed.");
};

socket.onerror = function(error) {
  console.error("WebSocket error:", error);
};

document.addEventListener('click', function(e){
  clickedElement = e.target;
  console.log(clickedElement);
});
