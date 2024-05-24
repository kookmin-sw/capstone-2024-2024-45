""" Account Core DB Model
"""
from uuid import uuid4

from sqlmodel import SQLModel, Field, Column, JSON

class Account(SQLModel):
    account_id: str = Field(primary_key = True, default_factory = uuid4().hex)
    type: str = Field(nullable = False)
    balance: int = Field(nullable = False)
    password: str = Field(nullable = False)
    username: str = Field(nullable = False)
    mobile_number: str = Field(nullable = False)
    created_at: str = Field(nullable = False)
    user_id: str = Field(nullable = False)
    account_name: str = Field(nullable = False)
    is_suspended: bool = Field(default = False)
    suspend_type: str = Field(nullable = True)