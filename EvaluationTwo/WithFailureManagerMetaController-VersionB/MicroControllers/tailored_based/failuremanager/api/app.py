from prometheus_fastapi_instrumentator import Instrumentator
from fastapi import FastAPI
import logging
from pydantic import BaseModel


app = FastAPI()
Instrumentator().instrument(app).expose(app)


class Failure(BaseModel):
    name: str
    type: str
    message: str
    dateevent: str


@app.get("/hello")
def hello_world():
    return "Hello"


@app.post("/insufficientcpu")
async def create_failure_insufficientCPU(request: Failure):
    logging.warn(request)
    return "Waiting for metacontroller probe."
