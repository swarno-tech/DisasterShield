import os
from dotenv import load_dotenv
load_dotenv()


class BaseConfig:

    # Flask
    SECRET_KEY = os.getenv("SECRET_KEY", "dev-secret-key")
    DEBUG = False
    TESTING = False

    # Database
    SQLALCHEMY_DATABASE_URI = os.getenv(
        "DATABASE_URL",
        "postgresql://postgres:postgres@localhost:5432/disastersync"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    #OSRM 
    OSRM_BASE_URL = os.getenv(
        "OSRM_BASE_URL",
        "http://localhost:5000"
    )
    OSRM_PROFILE = "driving"
    OSRM_TIMEOUT_SECONDS = 5

    #Weather
    WEATHER_API_KEY = os.getenv("WEATHER_API_KEY")
    HYDROLOGY_MODE = "SIMULATED"

    # SocketIO
    SOCKETIO_MESSAGE_QUEUE = None

    # Environment
    ENV = os.getenv("FLASK_ENV", "development")
