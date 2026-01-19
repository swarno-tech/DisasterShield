from app.extensions.db import db

class AlertResponse(db.Model):
    __tablename__ = "alert_responses"

    id = db.Column(db.Integer, primary_key=True)

    zone_id = db.Column(
        db.Integer,
        db.ForeignKey("zones.id"),
        nullable=False
    )

    phone_number = db.Column(db.String(20), nullable=True)

    response = db.Column(db.String(10))  # SAFE or HELP

    responded_at = db.Column(db.DateTime)

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.now()
    )
