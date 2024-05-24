""" 계좌 조회 관련 스키마 모음
"""
from typing import Dict, List

from sqlmodel import SQLModel

from .create_account import AccountType

class PasswordIn(SQLModel, table = False):
    account_id: str
    password: str

class GetPasswordOut(SQLModel, table = False):
    is_success: bool
    status_code: int
    message: str
    result: str

class ResetPasswordOut(SQLModel, table = False):
    is_success: bool
    status_code: int
    message: str
    result: str

class UserIdIn(SQLModel, table = False):
    user_id: str

class AccountInfo(SQLModel, table = False):
    account_id: str
    account_type: AccountType
    balance: int
    password: str
    username: str
    mobile_name: str
    created_at: str
    user_id: str
    account_name: str

class GetAccountInfoOut(SQLModel, table = False):
    is_success: bool
    status_code: int
    message: str
    result: AccountInfo

class GetAllAccountInfoOut(SQLModel, table = False):
    is_success: bool
    status_code: int
    message: str
    result: List[AccountInfo]

class EditNicknameIn(SQLModel, table = False):
    account_id: str
    name: str

class Balance(SQLModel, table = False):
    balance: int

class BalanceOut(SQLModel, table = False):
    is_success: bool
    status_code: int
    message: str
    result: Balance