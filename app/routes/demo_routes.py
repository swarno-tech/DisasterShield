from flask import Blueprint, jsonify
from app.models.alert_response import AlertResponse

from flask import current_app

alert_bp = Blueprint("alert", __name__)


@alert_bp.route("/<int:zone_id>/stats", methods=["GET"])
def alert_stats(zone_id):
    total = AlertResponse.query.filter_by(zone_id=zone_id).count()

    safe = AlertResponse.query.filter_by(
        zone_id=zone_id, response="SAFE"
    ).count()

    help_ = AlertResponse.query.filter_by(
        zone_id=zone_id, response="HELP"
    ).count()

    no_reply = total - safe - help_

    return jsonify({
        "zone_id": zone_id,
        "total": total,
        "safe": safe,
        "help": help_,
        "no_reply": no_reply
    })

# @alert_bp.route("/debug/db")
# def debug_db():
#     return {
#         "db_uri": current_app.config["SQLALCHEMY_DATABASE_URI"]
#     }