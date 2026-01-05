from app.extensions import db
from app.models.env_data import EnvData
from app.models.zone import Zone
from app.extensions.ml import ml_model, ml_scaler
from app.ml.preprocessing import prepare_lstm_input
from app.services.alert_services import trigger_alert


def evaluate_zone_risk(zone_id, timesteps=6):
    zone = Zone.query.get_or_404(zone_id)

    records = (
        EnvData.query
        .filter_by(zone_id=zone_id)
        .order_by(EnvData.recorded_at.asc())
        .all()
    )

    if len(records) < timesteps:
        return
    
    if ml_model is None or ml_scaler is None:
        return

    X = prepare_lstm_input(
        records[-timesteps:],
        ml_scaler,
        timesteps=timesteps
    )

    predictions = ml_model.predict(X)[0]

    labels = ["LOW", "MEDIUM", "HIGH"]
    predicted_risk = labels[predictions.argmax()]

    zone.risk_level = predicted_risk
    db.session.commit()

    if predicted_risk =="HIGH":
        trigger_alert(zone)
