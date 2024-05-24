""" Account Core 관련 exception 스키마를 모아 놓은 모듈
"""
from fastapi import HTTPException, status

class NoSuchAccountID(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_404_NOT_FOUND
        self.detail = "잘못된 account id입니다."