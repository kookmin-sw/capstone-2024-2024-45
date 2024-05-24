""" fastapi app 실행을 위한 메인 클라이언트
"""
from fastapi import FastAPI

from routers import auth_router

app = FastAPI(version = "0.0.1")

app.include_router(auth_router)