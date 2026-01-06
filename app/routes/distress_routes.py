from flask import Blueprint, request, jsonify
from app.extensions import db
from app.models.distress import Distress

distress_bp = Blueprint("distress", __name__)


@distress_bp.route("", methods=["POST"])
def create_distress():
    data = request.get_json()

    distress = Distress(
        zone_id=data["zone_id"],
        latitude=data["latitude"],
        longitude=data["longitude"]
    )

    db.session.add(distress)
    db.session.commit()

    return jsonify({"message": "Distress created"}), 201
