from sqlmodel import SQLModel

class TokenResponse(SQLModel, table = False):
    token_type: str
    access_token: str
    refresh_token: str

class TokenPayload(SQLModel, table = False):
    access_token: str
    refresh_token: str

class VerifyTokenOut(SQLModel, table = False):
    is_refresh: bool
    data: str