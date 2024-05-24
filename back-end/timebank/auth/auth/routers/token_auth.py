from fastapi import Depends, APIRouter
from fastapi.security import OAuth2PasswordRequestForm, OAuth2PasswordBearer

from services import UserTokenCreator, AdminTokenCreator, TokenVerify
# from database import get_session
from schema import TokenPayload, TokenResponse
from auth import authenticate

auth_router = APIRouter(
    prefix = "/api/auth", tags = ["auth"]
)

@auth_router.post("/user/token")
async def token_user(
    device_id: str
    ) -> TokenResponse:
    result = await UserTokenCreator(device_id).create_token()

    return 200, result

@auth_router.post("/admin/token")
async def token_admin(
    user: OAuth2PasswordRequestForm = Depends()
    ) -> TokenResponse:
    result = await AdminTokenCreator(user).create_token()

    return 200, result

@auth_router.post("/verify")
async def verify_token(
    token: TokenPayload = Depends(authenticate)
    ) -> bool:
    result = await TokenVerify(token).verify_token()

    return result