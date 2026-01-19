import random
from datetime import datetime
from app.extensions import db
from app.models.alert_response import AlertResponse
from app.models.user import User

def simulate_alert_responses(zone):
    users = User.query.filter_by(
        zone_id=zone.id,
        is_active=True
    ).all()
    for user in users:
        r = random.random()

        if r < 0.15:
            resp = "HELP"
        elif r < 0.55:
            resp = "SAFE"
        else:
            resp = None  # no reply

        response = AlertResponse(
            zone_id=zone.id,
            phone_number=user.phone_number,
            response=resp,
            responded_at=datetime.utcnow() if resp else None
        )

        db.session.add(response)

    db.session.commit()
