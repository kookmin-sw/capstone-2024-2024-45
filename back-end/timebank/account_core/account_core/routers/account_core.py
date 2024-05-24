""" Account Core 서비스 라우터
"""
from fastapi import Depends, APIRouter

from database import get_session
from schema import CreateAccountIn, CreateAccountOut, PasswordIn, Balance
from services import AccountCreator, GetPassword, ChangePassword, GetAccountInfo, GetBalance, ChangeBalance

core_router = APIRouter(
    prefix = "/api/accounts", tags = ["account_core"]
)

@core_router.post("/register")
async def create_account(
    account_info: CreateAccountIn,
    session = Depends(get_session)
    ):
    """ 계좌 개설 api
    """
    result = await AccountCreator(session).create_account(account_info)
    return result

@core_router.get("/{account_id}/password")
async def get_password(account_id, session = Depends(get_session)):
    """ 비밀번호 확인 api
    """
    result = await GetPassword(session).get_password(account_id)
    return result

@core_router.patch("{account_id}/password")
async def reset_password(account_id, info: PasswordIn, session = Depends(get_session)):
    """ 비밀번호 재설정 api
    """
    result = await ChangePassword(session).change_password(account_id, info)
    return result

@core_router.get("/{user_id}/all")
async def get_accounts_by_user_id(session = Depends(get_session)):
    """ 특정 사용자가 가지고 있는 모든 계좌 정보 조회 api
    """
    pass

@core_router.get("/{account_id}/info")
async def get_account(account_id, session = Depends(get_session)):
    """ account_id를 이용하여 특정 계좌 정보 조회 api
    """
    result = await GetAccountInfo(session).get_account_info(account_id)
    return result

@core_router.get("/{account_id}/balance")
async def get_balance(account_id, session = Depends(get_session)):
    """ account_id를 이용하여 특정 계좌의 잔액 조회 api
    """
    result = await GetBalance(session).get_balance(account_id)
    return result

@core_router.patch("/{account_id}/balance")
async def change_balance(account_id, info: Balance,session = Depends(get_session)):
    """ 특정 계좌의 잔액을 수정하는 api
    """
    result = await ChangeBalance(session).change_balance(info)
    return result