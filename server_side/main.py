from typing import Union

from fastapi import FastAPI, Request, WebSocket, WebSocketDisconnect

app = FastAPI()
websocket_connections = set()

@app.get("/")
def read_root():
    return {"code": "some random code"}

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    websocket_connections.add(websocket)

    try:
        while True:
            data = await websocket.receive_text()
            # Process received data from the extension
    except WebSocketDisconnect:
        websocket_connections.remove(websocket)

@app.post("/send_message")
async def send_message(request: Request):
    stuff = await request.json()
    print(stuff)
    message = "Hello from the server!"

    for websocket in websocket_connections:
        await websocket.send_text(stuff['title'])

    return {"message": "Message sent to all connected extensions."}

