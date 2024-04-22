""" user 관련 exception 스키마를 모아 놓은 모듈
"""

from fastapi import HTTPException, status

class UserCreateFailError(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_400_BAD_REQUEST
        self.detail = "유저 생성에 실패하였습니다."

class ProfileCreateFailError(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_400_BAD_REQUEST
        self.detail = "프로필 생성에 실패하였습니다."

class NoSuchUserID(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_404_NOT_FOUND
        self.detail = "잘못된 uesr id입니다."

class NoSuchDeviceID(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_404_NOT_FOUND
        self.detail = "잘못된 device id입니다."

class NicknameChangeFailError(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_400_BAD_REQUEST
        self.detail = "닉네임 변경에 실패하였습니다."