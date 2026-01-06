from flask import Blueprint, jsonify
from app.services.risk_service import evaluate_zone_risk

risk_bp = Blueprint("risk", __name__)


@risk_bp.route("/<int:zone_id>", methods=["POST"])
def run_risk(zone_id):
    evaluate_zone_risk(zone_id)
    return jsonify({"message": "Risk evaluation triggered"})
