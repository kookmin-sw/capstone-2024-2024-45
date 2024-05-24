""" access token과 refresh token을 발급하고 검증하는 모듈
"""

import time, os
from typing import Dict, Tuple, Union
from datetime import datetime, timedelta, timezone

from jose import jwt, JWTError
from dotenv import load_dotenv

from exception import NoSuchTokenError, AccessTokenExpiredError, RefreshTokenExpiredError, InvalidTokenError

load_dotenv("../.env")

def create_new_token(id: str) -> Tuple[str, str]:
    """ access token과 refresh token을 발급하는 메서드

    Args:
        id (str): token을 발급할 대상 id -> (일반 유저: device_id, 기업 유저: id/password)

    Returns:
        access_token (str): JWT ATK
        refresh_token (str): JWT RTK
    """
    payload_access = {
        "id": id,
        "type": "access",
        "expires": time.time() + 36000
    }

    payload_refresh = {
        "id": id,
        "type": "refresh",
        "expires": time.time() + 86400 * 30
    }

    access_token = jwt.encode(payload_access, os.environ["SECRET_KEY"], algorithm = "HS256")
    refresh_token = jwt.encode(payload_refresh, os.environ["SECRET_KEY"], algorithm = "HS256")
    
    return access_token, refresh_token

def verify_access_token(access_token: str, refresh_token: str) -> Tuple[bool, str]:
    """ access token의 유효성을 검증하고, 만료되었을 시에 refresh token을 통해서
        access token을 재발급하는 메서드

    Args:
        access_token (str): JWT ATK
        refresh_token (str): JWT RTK

    Returns:
        Tuple[bool, str]: 유효한 token인 경우, user_id / access token이 재발급된 경우, access token
    """
    try:
        data = jwt.decode(access_token, os.environ["SECRET_KEY"], algorithms = ["HS256"])
        expire = data.get("expires")

        if(expire is None):
            raise NoSuchTokenError

        if(datetime.now(timezone.utc) > datetime.fromtimestamp(expire, tz = timezone.utc)):
            new_access_token = refresh_access_token(refresh_token)
            return True, new_access_token

        return False, data.get("id")

    except JWTError:
        raise InvalidTokenError

def refresh_access_token(refresh_token: str) -> str:
    """ refresh token을 통해서 access token을 재발급하는 메서드

    Args:
        refresh_token (str): JWT RTK

    Returns:
        str: 새 access token
    """
    try:
        data = jwt.decode(refresh_token, os.environ["SECRET_KEY"], algorithms=["HS256"])
        if(data.get("type") != "refresh"):
            raise InvalidTokenError

        if(datetime.now(timezone.utc) > datetime.fromtimestamp(data.get("expires"), tz = timezone.utc)):
            raise RefreshTokenExpiredError

        # 새로운 액세스 토큰 발급
        user_id = data.get("id")
        access_token, _ = create_new_token(user_id)
        return access_token

    except JWTError:
        raise InvalidTokenError