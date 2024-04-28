from sqlmodel import SQLModel, Field
from uuid import uuid4
from enum import Enum
from typing import List

class Gender(str, Enum):
    Female = "female"
    Male = "male"

class Permission(str, Enum):
    ReadOnly = 'r'
    ReadWrite = "rw"

class CreateProfileIn(SQLModel, table = False):
    nickname: str
    image_url: str

class AccountInfo(SQLModel, table = False):
    user_id: str
    account_id: str
    name: str
    permission: Permission

class CreateUserIn(SQLModel, table = False):
    mobile_number: str
    name: str
    gender: Gender
    profile_info: CreateProfileIn

class CreateUserOut(SQLModel, table = False):
    user_id: str

class UserNicknameIn(SQLModel, table = False):
    nickname: str

class GetUserIdOut(SQLModel, table = False):
    user_id: str

class GetUserInfoOut(SQLModel, table = False):
    user_id: str
    device_id: str
    mobile_number: str
    name: str
    gender: Gender
    profile_info: CreateProfileIn
    created_at: str
    accounts: List[AccountInfo]