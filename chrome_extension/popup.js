const socket = new WebSocket("wss://dev.dumitru.fr:80/ws");
let clickedElement;

socket.onopen = function(_event) {
  console.log("WebSocket connection established.");
  socket.send("Hello from the extension!");
};

socket.onmessage = function(event) {
  if (clickedElement.tagName === 'INPUT' || clickedElement.tagName === 'TEXTAREA')
    clickedElement.value = event.data;
  else 
    alert("Non puoi scrivere qui, clicca la casella giusta")
};

socket.onclose = function(_event) {
  console.log("WebSocket connection closed.");
};

socket.onerror = function(error) {
  console.error("WebSocket error:", error);
};

document.addEventListener('click', function(e){
  clickedElement = e.target;
});
