from .base import BaseConfig

class DevConfig(BaseConfig):
    DEBUG = True

    SQLALCHEMY_DATABASE_URI = (
        "postgresql://postgres:postgres@localhost:5432/disastersync"
    )

    ENABLE_JOBS = False
