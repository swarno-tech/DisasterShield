from flask import Blueprint, jsonify
from app.models.resource import Resource

resource_bp = Blueprint("resources", __name__)


@resource_bp.route("", methods=["GET"])
def list_resources():
    resources = Resource.query.all()

    return jsonify([
        {
            "id": r.id,
            "name": r.name,
            "latitude": r.latitude,
            "longitude": r.longitude,
            "available": r.is_available
        } for r in resources
    ])
