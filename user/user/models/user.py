from uuid import uuid4
from enum import Enum
from datetime import datetime

from sqlmodel import SQLModel, Field

class Role(str, Enum):
    user = "User"
    company = "Company"

class Gender(str, Enum):
    male = "Male"
    female = "Female"

class User(SQLModel):
    """ User table의 스키마

    Notes:
        create_at에서 날짜를 어느 단위까지 저장할지 논의 필요함
    """
    user_id: str = Field(primary_key = True, default_factory = uuid4().hex)
    device_id: str = Field(nullable = False)
    mobile_number: str = Field(nullable = False)
    role: Role = Field(nullable = False, default = Role.user)
    name: str = Field(nullable = False)
    gender: Gender = Field(nullable = False)
    create_at: str = Field(default_factory = datetime.date())