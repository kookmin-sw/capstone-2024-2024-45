from fastapi import HTTPException, status

class UserTokenCreateFailError(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_404_NOT_FOUND
        self.detail = "invalid device_id"

class AdminTokenCreateFailError(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_404_NOT_FOUND
        self.detail = "invalid user info"

class TokenNotFoundError(HTTPException):
    def __init__(self):
        self.status_code = status.HTTP_403_FORBIDDEN,
        self.detail = "get access token for authenticate"