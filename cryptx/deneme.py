
import websockets

websocket = "wss://stream.binance.com:9443/ws/!miniTicker@arr"

async def hello():
    async with websockets.connect("ws://localhost:8765") as websocket:
        await websocket.send("Hello world!")
        await websocket.recv()