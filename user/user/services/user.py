from sqlmodel import select
from uuid import uuid4

from models import User, UserAccount, UserProfile
from exception import UserCreateFailError, ProfileCreateFailError, NoSuchUserID, NoSuchDeviceID, NicknameChangeFailError
from schema import CreateUserIn, CreateProfileIn, UserNicknameIn, Gender
        
class UserCreator:
    def __init__(self, session):
        self.session = session

    async def create_profile(self, user_id, profile_info: CreateProfileIn):
        profile_object = UserProfile(
            user_id = user_id,
            nickname = profile_info.nickname,
            image_url = profile_info.image_url
        )

        try:
            self.session.add(profile_object)
            self.session.commit()
        except:
            raise ProfileCreateFailError

    async def create_user(self, device_id, user_info: CreateUserIn):
        user_id = uuid4().hex

        print("gender : ", type(user_info.gender))
        user_object = User(
            user_id = user_id,
            device_id = device_id,
            mobile_number = user_info.mobile_number,
            name = user_info.name,
            gender = user_info.gender
        )

        try:
            self.session.add(user_object)
            self.session.commit()
        except Exception as e:
            print(e)
            raise UserCreateFailError

        return user_id

class GetUser:
    def __init__(self, session):
        self.session = session

    async def get_user_object(self, user_id):
        try:
            user_object = self.session.exec(select(User).where(
                User.user_id == user_id,
            )).one()
        except:
            raise NoSuchUserID

        return user_object

class GetUserID:
    def __init__(self, session):
        self.session = session

    async def get_user_id(self, device_id):
        try:
            user_object = self.session.exec(select(User).where(
                User.device_id == device_id,
            )).one()
        except:
            raise NoSuchDeviceID

        return user_object.user_id

class NicknameChanger(GetUser):
    def __init__(self, session):
        super().__init__(session)

    async def change_nickname(self, user_id, info: UserNicknameIn):
        user_object = await self.get_user_object(user_id = user_id)

        try:
            user_object.name = info.nickname
            self.session.add(user_object)
            self.session.commit()
            self.session.refresh(user_object)
        except:
            raise NicknameChangeFailError