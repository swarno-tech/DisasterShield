from flask import Blueprint, jsonify
from app.models.dispatch import Dispatch

dispatch_bp = Blueprint("dispatch", __name__)


@dispatch_bp.route("/<int:distress_id>", methods=["GET"])
def get_dispatch(distress_id):
    dispatch = Dispatch.query.filter_by(distress_id=distress_id).first_or_404()

    return jsonify({
        "status": dispatch.status,
        "eta_minutes": dispatch.eta_minutes
    })
