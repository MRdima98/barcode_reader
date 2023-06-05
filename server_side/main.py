from typing import Union

from fastapi import FastAPI, Request, WebSocket, WebSocketDisconnect

app = FastAPI()
websocket_connections = set()

@app.get("/")
def read_root():
    return {"homepage": "Hello world"}

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    websocket_connections.add(websocket)

    try:
        while True:
            data = await websocket.receive_text()
    except WebSocketDisconnect:
        websocket_connections.remove(websocket)

@app.post("/send_message")
async def send_message(request: Request):
    message = await request.json()
    print(message)

    for websocket in websocket_connections:
        await websocket.send_text(message['qrCode'])

    return {"message": "Message sent to all connected extensions."}

