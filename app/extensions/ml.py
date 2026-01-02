import joblib
from tensorflow.keras.models import load_model

ml_model = None
ml_scaler = None


def load_ml_assets(app):
    global ml_model, ml_scaler

    model_path = app.config.get("ML_MODEL_PATH")
    scaler_path = app.config.get("ML_SCALER_PATH")

    if not model_path or not scaler_path:
        app.logger.warning("ML model/scaler path not configured")
        return

    try:
        ml_model = load_model(model_path)
        ml_scaler = joblib.load(scaler_path)
        app.logger.info("ML model and scaler loaded successfully")
    except Exception as e:
        app.logger.error(f"Error loading ML assets: {e}")
