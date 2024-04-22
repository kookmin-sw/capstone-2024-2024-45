from sqlmodel import SQLModel, Session, create_engine
import os
from dotenv import load_dotenv

load_dotenv("../.env")

database_file = os.environ["DATABASE_NAME"]
database_connection_string = f"sqlite:///{database_file}"
engine_url = create_engine(database_connection_string, echo = True)

SQLModel.metadata.create_all(engine_url)

def get_session():
    with Session(engine_url) as session:
        yield session