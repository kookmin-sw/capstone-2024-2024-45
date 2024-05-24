""" DB connection session을 관리하는 모듈
"""

from sqlmodel import SQLModel, Session, create_engine
import os

# ncp 세팅 전에 로컬에서 테스트하기 위한 테스트 db 세팅 코드
database_file = os.environ["DATABASE_NAME"]
database_connection_string = f"sqlite:///{database_file}"
engine_url = create_engine(database_connection_string, echo = True)

SQLModel.metadata.create_all(engine_url)

def get_session():
    with Session(engine_url) as session:
        yield session