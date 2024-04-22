from sqlmodel import SQLModel, Field

from .user import User

class UserProfile(SQLModel):
    """ User Profile table의 스키마

    Notes:
        profile_img는 image file이 저장되어 있는 storage 접근 url
    """
    user_id: str = Field(foreign_key = User.user_id)
    nickname: str = Field(unique = False, nullable = False)
    profile_img: str = Field(default = "기본 image url", nullable = True)