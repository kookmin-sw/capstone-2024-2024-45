from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer

from exception import TokenNotFoundError
from .jwt_handler import verify_access_token

oauth2_schema = OAuth2PasswordBearer(tokenUrl = "/api/auth/verify")

def authenticate(access_token: str = Depends(oauth2_schema),
                 refresh_token: str = Depends(oauth2_schema)) -> str:
    if(not access_token or not refresh_token):
        raise TokenNotFoundError

    decoded_token = verify_access_token(access_token, refresh_token)
    return True, decoded_token