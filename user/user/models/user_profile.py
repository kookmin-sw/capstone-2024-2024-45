from sqlmodel import SQLModel, Field
from uuid import uuid4

from .user import User

class UserProfile(SQLModel, table = True):
    """ User Profile table의 스키마

    Notes:
        profile_img는 image file이 저장되어 있는 storage 접근 url
    """
    user_profile_id: str = Field(primary_key = True, default_factory = lambda: uuid4().hex)
    user_id: str = Field(foreign_key = "user.user_id")
    nickname: str = Field(nullable = False)
    profile_img: str = Field(default = "기본 image url", nullable = True)