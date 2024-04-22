from sqlmodel import SQLModel
from typing import Any

class MessageOnly(SQLModel, table = False):
    is_success: bool
    code: int
    message: str
    result: Any