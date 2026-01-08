import os
from dotenv import load_dotenv
load_dotenv()


class BaseConfig:

    # Flask
    SECRET_KEY = os.getenv("SECRET_KEY", "dev-secret-key")
    DEBUG = False
    TESTING = False

    PORT = int(os.getenv("PORT", 5000))

    # Database
    SQLALCHEMY_DATABASE_URI = os.getenv(
        "DATABASE_URL",
        "postgresql://postgres:postgres@localhost:5432/disastersync"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    #OSRM 
    OSRM_BASE_URL = os.getenv(
        "OSRM_BASE_URL",

        "https://router.project-osrm.org"
    )
    OSRM_PROFILE = "driving"
    OSRM_TIMEOUT_SECONDS = 5

    #Weather
    OPENWEATHER_API_KEY = os.getenv("OPENWEATHER_API_KEY")
    HYDROLOGY_MODE = "DERIVED"

    # Environment
    ENV = os.getenv("FLASK_ENV", "development")

    # ML
    BASE_DIR = os.path.abspath(os.path.dirname(__file__))
    PROJECT_ROOT = os.path.abspath(os.path.join(BASE_DIR, ".."))

    ML_MODEL_PATH = os.path.join(PROJECT_ROOT, "ml", "flood_lstm_risk_model.h5")
    ML_SCALER_PATH = os.path.join(PROJECT_ROOT, "ml", "scaler.pkl")