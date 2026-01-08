from flask import Blueprint, jsonify
from app.models.zone import Zone
from app.services.risk_service import evaluate_zone_risk

risk_bp = Blueprint("risk", __name__)


@risk_bp.route("/<int:zone_id>/run", methods=["POST"])
def run_risk(zone_id):
    risk = evaluate_zone_risk(zone_id)
    return jsonify({
        "message": "Risk evaluation triggered",
        "risk_level": risk
    })


@risk_bp.route("/<int:zone_id>", methods=["GET"])
def get_risk(zone_id):
    zone = Zone.query.get_or_404(zone_id)
    return jsonify({
        "zone_id": zone.id,
        "risk_level": zone.risk_level
    })
