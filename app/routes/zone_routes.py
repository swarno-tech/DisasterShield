from flask import Blueprint, request, jsonify
from app.extensions import db
from app.models.zone import Zone
from app.services.alert_services import trigger_alert

zone_bp = Blueprint("zones", __name__)

@zone_bp.route("/", methods=["POST"])
def create_zone():
    data = request.get_json()

    required_fields = ["name", "latitude", "longitude"]
    for field in required_fields:
        if field not in data:
            return jsonify({"error": f"{field} is required"}), 400

    zone = Zone(
        name=data["name"],
        latitude=data["latitude"],
        longitude=data["longitude"],
    )

    db.session.add(zone)
    db.session.commit()

    return jsonify({
        "message": "Zone created",
        "zone_id": zone.id
    }), 201

@zone_bp.route("/", methods=["GET"])
def list_zones():
    zones = Zone.query.all()

    response = []
    for z in zones:
        response.append({
            "id": z.id,
            "name": z.name,
            "latitude": z.latitude,
            "longitude": z.longitude,
            "risk_level": z.risk_level
        })

    return jsonify(response), 200

@zone_bp.route("/<int:zone_id>", methods=["GET"])
def get_zone(zone_id):
    zone = Zone.query.get_or_404(zone_id)

    return jsonify({
        "id": zone.id,
        "name": zone.name,
        "latitude": zone.latitude,
        "longitude": zone.longitude,
        "risk_level": zone.risk_level
    }), 200

@zone_bp.route("/<int:zone_id>/risk/high", methods=["POST"])
def force_high_risk(zone_id):
    zone = Zone.query.get_or_404(zone_id)
    zone.risk_level = "HIGH"
    db.session.commit()

    trigger_alert(zone)

    return jsonify({
        "message": "Zone risk manually set to HIGH",
        "zone_id": zone.id
    })