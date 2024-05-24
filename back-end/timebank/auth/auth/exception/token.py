""" token 관련 exception 모듈
"""

from fastapi import HTTPException, status

class NoSuchTokenError(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_400_BAD_REQUEST,
        self.detail = "no such token supplied"

class AccessTokenExpiredError(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_403_FORBIDDEN
        self.detail = "access token expired"

class RefreshTokenExpiredError(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_403_FORBIDDEN
        self.detail = "refresh token expired"

class InvalidTokenError(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_400_BAD_REQUEST
        self.detail = "invalid token"