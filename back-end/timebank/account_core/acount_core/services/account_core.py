""" 계좌 정보 관련 CRUD 모듈
"""
from sqlmodel import select

from models import Account
from exception import NoSuchAccountID

class GetAccount:
    def __init__(self, session):
        self.session = session

    def get_account_object(self, account_id):
        try:
            account_object = self.session.exec(select(Account).where(
                Account.account_id == account_id,
            )).one()
        except:
            raise NoSuchAccountID

        return account_object

class GetPassword(GetAccount):
    def __init__(self, session):
        super().__init__(session)

    def get_password(self, account_id: str):
        return self.get_account_object(account_id)["password"]

class ChangePassword(GetAccount):
    def __init__(self, session):
        super().__init__(session)

    def change_password(self, account_id, password):
        account_object = self.get_account_object(account_id)

        try:
            account_object.password = password
            self.session.add(account_object)
            self.session.commit()
            self.session.refresh(account_object)
        except:
            raise None

        return password

class ChangeNickname(GetAccount):
    def __init__(self, session):
        super().__init__(session)

    def change_nickname(self, account_id, nickname):
        account_object = self.get_account_object(account_id)

        try:
            account_object.nickname = nickname
            self.session.add(account_object)
            self.session.commit()
            self.session.refresh(account_object)
        except:
            raise None

        return nickname

class GetAccountInfo(GetAccount):
    def __init__(self, session):
        super().__init__(session)

    def get_account_info(self, account_id):
        return self.get_account_object(account_id)

class GetBalance(GetAccount):
    def __init__(self, session):
        super().__init__(session)

    def get_balance(self, account_id):
        return self.get_account_object(account_id)["balance"]

class ChangeBalane(GetAccount):
    def __init__(self, session):
        super().__init__(session)

    def change_balance(self, account_id, balance):
        account_object = self.get_account_object(account_id)

        try:
            account_object.balance = balance
            self.session.add(account_object)
            self.session.commit()
            self.session.refresh(account_object)
        except:
            raise None

        return balance