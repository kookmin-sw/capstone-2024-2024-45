""" 계좌 개설 관련 exception 스키마를 모아 놓은 모듈
"""

from fastapi import HTTPException, status

class AccountCreateFailError(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_400_BAD_REQUEST
        self.detail = "개설에 실패하였습니다."