from flask import Blueprint, request, jsonify
from app.extensions import db
from app.models.env_data import EnvData
from app.services.risk_service import evaluate_zone_risk

env_data_bp = Blueprint("env_data", __name__)


@env_data_bp.route("", methods=["POST"])
def add_env_data():
    data = request.get_json()

    record = EnvData(
        zone_id=data["zone_id"],
        rainfall=data["rainfall"],
        river_discharge=data["river_discharge"],
        water_level=data["water_level"],
        humidity=data["humidity"],
        temperature=data["temperature"]
    )

    db.session.add(record)
    db.session.commit()
    evaluate_zone_risk(record.zone_id)

    return jsonify({"message": "Env data added"}), 201
