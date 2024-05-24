""" 계좌 개설 관련 CRUD 모듈
"""
from uuid import uuid4

from schema import CreateAccountIn
from models import Account
from exception import AccountCreateFailError

class AccountCreator:
    def __init__(self, session):
        self.session = session

    async def create_account(self, account_info: CreateAccountIn):
        account_id = uuid4().hex
        account_object = Account(
            account_id = account_id,
            type = account_info.type,
            balance = account_info.balance,
            password = account_info.password,
            username = account_info.username,
            mobile_number = account_info.mobile_number,
            created_at = account_info.created_at,
            user_id = account_info.user_id,
            account_name = account_info.account_name
        )

        try:
            self.session.add(account_object)
            self.session.commit()
        except Exception as e:
            raise AccountCreateFailError

        return account_id