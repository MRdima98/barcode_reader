import uvicorn
from typing import Union

from fastapi import FastAPI, Request, WebSocket, WebSocketDisconnect
from fastapi.responses import FileResponse
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

app = FastAPI()
app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")
websocket_connections = set()

@app.get("/")
def read_root(request: Request):
    return templates.TemplateResponse("index.html", { "request":request })
    #return FileResponse('index.html')

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

if __name__ == '__main__':
    uvicorn.run(
            'main:app', port=443, host='0.0.0.0',
            ssl_keyfile='/etc/letsencrypt/live/dev.dumitru.fr/privkey.pem',
            ssl_certfile='/etc/letsencrypt/live/dev.dumitru.fr/cert.pem')
