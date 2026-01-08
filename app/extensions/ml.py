import joblib
import os

ml_model = None
ml_scaler = None

def load_ml_assets(app):
    global ml_model, ml_scaler
    from tensorflow.keras.models import load_model

    if ml_model is not None and ml_scaler is not None:
        app.logger.info("ML already loaded, skipping")
        return

    model_path = app.config.get("ML_MODEL_PATH")
    scaler_path = app.config.get("ML_SCALER_PATH")

    app.logger.info(f"Loading ML model from: {model_path}")
    app.logger.info(f"Loading ML scaler from: {scaler_path}")

    try:
        if not os.path.exists(model_path):
            raise FileNotFoundError(f"Model not found at {model_path}")

        if not os.path.exists(scaler_path):
            raise FileNotFoundError(f"Scaler not found at {scaler_path}")

        ml_model = load_model(model_path, compile=False)
        ml_scaler = joblib.load(scaler_path)

        app.logger.info("ML assets loaded successfully")

    except Exception as e:
        app.logger.exception("ML load failed")
        ml_model = None
        ml_scaler = None
