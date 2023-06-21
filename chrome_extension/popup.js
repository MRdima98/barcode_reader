const socket = new WebSocket("wss://dev.dumitru.fr:80/ws");

socket.onopen = function(_event) {
  console.log("WebSocket connection established.");
  socket.send("Hello from the extension!");
};

socket.onmessage = function(event) {
  document.activeElement.value = event.data;
};

socket.onclose = function(_event) {
  console.log("WebSocket connection closed.");
};

socket.onerror = function(error) {
  console.error("WebSocket error:", error);
};
