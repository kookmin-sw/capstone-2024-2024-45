""" user service의 router 모듈
"""
from database import get_session
from fastapi import APIRouter, Depends
from schema import MessageOnly, CreateUserIn, UserNicknameIn
from services import UserCreator, GetUser, GetUserID, NicknameChanger

user_router = APIRouter(
    prefix = "/api/user", tags = ["user"]
)

@user_router.post("/{device_id}")
async def create_user(info: CreateUserIn,
                      session = Depends(get_session)
                    ) -> MessageOnly:
    user_creator = UserCreator(
        session = session
    )

    user_id = await user_creator.create_user(info)
    result = await user_creator.create_profile(user_id, info.profile_info)

    return {
        "is_success": True,
        "status_code": 200,
        "message": "user created successfully",
        "result": {
            "user_id": user_id
        }
    }

@user_router.get("/{device_id}")
async def get_user_id(device_id, session = Depends(get_session)) -> MessageOnly:
    user_id = GetUserID(session).get_user_id(device_id)

    return {
        "is_success": True,
        "status_code": 200,
        "message": "get user id successfully",
        "result": {
            "user_id": user_id
        }
    }

@user_router.get("/{user_id}")
async def get_user_info(user_id, session = Depends(get_session)) -> MessageOnly:
    user_object = await GetUser(session).get_user_object(user_id)

    return {
        "is_success": True,
        "status_code": 200,
        "message": "get user successfully",
        "result": user_object
    }

@user_router.patch("{user_id}/nickname")
async def change_nickname(user_id, info: UserNicknameIn, session = Depends(get_session)) -> MessageOnly:
    result = await NicknameChanger(session).change_nickname(user_id, info)

    return {
        "is_success": True,
        "status_code": 200,
        "message": "닉네임이 성공적으로 변경되었습니다.",
        "result": None
    }

@user_router.patch("{user_id}/")
async def change_profile_image(user_id) -> MessageOnly:
    pass