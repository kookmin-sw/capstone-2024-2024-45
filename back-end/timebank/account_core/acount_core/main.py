""" Account Core 서비스의 메인 클라이언트
"""
from fastapi import FastAPI

from routers import core_router

app = FastAPI(version = "0.0.1")

app.include_router(core_router)