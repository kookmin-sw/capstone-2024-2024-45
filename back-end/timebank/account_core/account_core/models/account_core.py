""" Account Core DB Model
"""
from uuid import uuid4
from datetime import date

from sqlmodel import SQLModel, Field, Column, JSON

class Account(SQLModel, table = True):
    account_id: str = Field(primary_key = True, nullable = False)
    type: str = Field(nullable = False)
    balance: int = Field(nullable = False)
    password: str = Field(nullable = False)
    username: str = Field(nullable = False)
    mobile_number: str = Field(nullable = False)
    created_at: date = Field(nullable = False, default_factory = date.today)
    user_id: str = Field(nullable = False)
    account_name: str = Field(nullable = False)
    is_suspended: bool = Field(default = False)
    suspend_type: str = Field(nullable = True)