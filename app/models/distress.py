from app.extensions.db import db


class Distress(db.Model):
    __tablename__ = "distress"

    id = db.Column(db.Integer, primary_key=True)

    zone_id = db.Column(
        db.Integer,
        db.ForeignKey("zones.id"),
        nullable=False
    )

    description = db.Column(db.Text)
    severity = db.Column(
        db.String(20),
        default="HIGH"
    )

    status = db.Column(
        db.String(20),
        default="OPEN" #OPEN or DISPATCHED
    )

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.now()
    )
