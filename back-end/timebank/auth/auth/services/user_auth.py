from typing import Dict, Any

from auth import HashPassword, create_new_token, verify_access_token
from exception import UserTokenCreateFailError, AdminTokenCreateFailError

class TokenCreator:
    """ token 생성을 위한 인터페이스

    Args:
        redis_session (session): redis에 rtk - device_id/user_info 저장을 위한
        session
    """
    def __init__(self):
        self.redis_session = None

    async def save_redis(self):
        """ redis server에 refresh_token - device_id/user_info를
            저장하는 메서드
        """
        pass

class UserTokenCreator(TokenCreator):
    def __init__(self, device_id):
        super().__init__()
        self.device_id = device_id

    async def verify_info(self, device_id: str) -> bool:
        """ user service에 api 요청을 통해서 device_id가 유효한지 확인하는 메서드

        Args:
            device_id (str): user 디바이스의 id

        Returns:
            bool: 유효한 device_id인지 여부

        Note:
            user service api 확인 필요함
        """
        pass

    async def create_token(self) -> Dict[str, str]:
        """ access token과 refresh token을 발급하는 메서드

        Returns:
            access_token (str): JWT ATK
            refresh_token (str): JWT RTK
            token_type (str): Bearer token type
        """
        if(await self.verify_info(self.device_id)):
            access_token, refresh_token = create_new_token(self.device_id)
            await self.save_redis(self.device_id, refresh_token)

            return {
                "access_token": access_token,
                "refresh_token": refresh_token,
                "token_type": "Bearer"
            }

        raise UserTokenCreateFailError

class AdminTokenCreator(TokenCreator):
    def __init__(self, user):
        super().__init__()
        self.user = user

    async def get_user_info(self, user_id: str):
        """ user service에 api 요청을 통해서 user_id에 맞는 user info를
            리턴받는 메서드

        Args:
            user_id (str): user_id
        Note:
            user service api 확인 필요함
        """
        pass

    async def create_token(self) -> Dict[str, str]:
        """ user_id와 password를 확인하여 토큰을 발급하는 메서드

        Returns:
            access_token (str): JWT ATK
            refresh_token (str): JWT RTK
            token_type (str): Bearer token type
        """
        user_data = await self.get_user_info(self.user.user_id)

        if(HashPassword().verify_hash(self.user.password, user_data.password)):
            access_token, refresh_token = create_new_token(user_data.user_id)
            await self.save_redis(self.user.user_id, refresh_token)
            
            return {
                "access_token": access_token,
                "refresh_token": refresh_token,
                "token_type": "Bearer"
            }

        raise AdminTokenCreateFailError

class TokenVerify:
    def __init__(self, token):
        self.access_token = token.access_token
        self.refresh_token = token.refresh_token

    def verify_token(self):
        is_refresh, data = verify_access_token(self.access_token, self.refresh_token)

        return {
            "is_refresh": is_refresh,
            "result": data
        }