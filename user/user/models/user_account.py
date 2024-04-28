from enum import Enum

from sqlmodel import SQLModel, Field, Column

from .user import User

class Permission(str, Enum):
    ReadWrite = "rw"
    ReadOnly = 'r'

class UserAccount(SQLModel, table = True):
    """ User Account table의 스키마

    Notes:
        permission의 경우, default 값을 rw로 설정해야 함
    """
    user_id: str = Field(foreign_key = "user.user_id")
    account_id: str = Field(primary_key = True, nullable = False)
    name: str = Field(nullable = False)
    permission: Permission = Field(default = Permission.ReadWrite, nullable = False)