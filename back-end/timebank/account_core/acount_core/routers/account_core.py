""" Account Core 서비스 라우터
"""
from fastapi import Depends, APIRouter

from database import get_session
from schema import CreateAccountIn, CreateAccountOut

core_router = APIRouter(
    prefix = "api/accounts", tags = ["account_core"]
)

@core_router.post("/register", response_model = CreateAccountOut)
async def create_account(
    account_info: CreateAccountIn,
    session = Depends(get_session)
    ) -> CreateAccountOut:
    """ 계좌 개설 api
    """
    pass

@core_router.get("/password")
async def get_password(session = Depends(get_session)):
    """ 비밀번호 확인 api
    """
    pass

@core_router.patch("/password")
async def reset_password(session = Depends(get_session)):
    """ 비밀번호 재설정 api
    """
    pass

@core_router.get("/{user_id}/all")
async def get_accounts_by_user_id(session = Depends(get_session)):
    """ 특정 사용자가 가지고 있는 모든 계좌 정보 조회 api
    """
    pass

@core_router.get("/{user_id}/info")
async def get_account(session = Depends(get_session)):
    """ account_id를 이용하여 특정 계좌 정보 조회 api
    """
    pass

@core_router.get("/{user_id}/balance")
async def get_balance(session = Depends(get_session)):
    """ account_id를 이용하여 특정 계좌의 잔액 조회 api
    """
    pass

@core_router.patch("/{user_id}/balance")
async def change_balance(session = Depends(get_session)):
    """ 특정 계좌의 잔액을 수정하는 api
    """
    pass