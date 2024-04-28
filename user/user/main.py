""" user service의 메인 클라이언트
"""
from fastapi import FastAPI
import os
from sqlmodel import SQLModel, create_engine

from routers import user_router

app = FastAPI(version = "0.0.1")

app.include_router(user_router)

@app.on_event("startup")
def on_startup():
    # database_file = os.environ["DB_NAME"]
    database_connection_string = "sqlite:///user-test.db"
    engine_url = create_engine(database_connection_string, echo = True)

    SQLModel.metadata.create_all(engine_url)