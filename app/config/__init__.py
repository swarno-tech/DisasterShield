import os

from .base import BaseConfig
from .dev import DevConfig
from .prod import ProdConfig


def get_config():
    env = os.getenv("FLASK_ENV", "development").lower()

    if env == "production":
        return ProdConfig
    return DevConfig
