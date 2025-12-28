from .base import BaseConfig
import os

class ProdConfig(BaseConfig):
    DEBUG = False

    SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL")

    ENABLE_JOBS = True

