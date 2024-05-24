""" 계좌 개설 관련 스키마 모음
"""
from sqlmodel import SQLModel
from enum import Enum

class AccountType(str, Enum):
    user = "User"
    company = "Company"

class CreateAccountIn(SQLModel, table = False):
    type: AccountType
    balance: int
    password: str
    username: str
    mobile_number: str
    created_at: str
    user_id: str
    account_name: str

class CreateAccountOut(SQLModel, table = False):
    is_success: bool
    status_code: int
    message: str
    result: str