import joblib

ml_model = None
ml_scaler = None


def load_ml_assets(app):
    global ml_model, ml_scaler
    from tensorflow.keras.models import load_model

    if ml_model is not None and ml_scaler is not None:
        return

    model_path = app.config.get("ML_MODEL_PATH")
    scaler_path = app.config.get("ML_SCALER_PATH")

    try:
        ml_model = load_model(model_path, compile=False)
        ml_scaler = joblib.load(scaler_path)
        app.logger.info("ML assets loaded")
    except Exception as e:
        app.logger.error(f"ML load failed: {e}")
        ml_model = None
        ml_scaler = None
