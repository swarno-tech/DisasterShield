from flask import current_app

from app.extensions.db import db
from app.models.zone import Zone
from app.services.risk_service import evaluate_zone_risk


def run_risk_evaluation():

    zones = Zone.query.all()

    if not zones:
        current_app.logger.info("No zones found for risk evaluation")
        return

    for zone in zones:
        try:
            evaluate_zone_risk(zone.id)
        except Exception as e:
            current_app.logger.error(
                f"Risk evaluation failed for zone {zone.id}: {e}"
            )

    db.session.commit()
