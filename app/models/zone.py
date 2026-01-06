from app.extensions.db import db


class Zone(db.Model):
    __tablename__ = "zones"

    id = db.Column(db.Integer, primary_key=True)

    name = db.Column(db.String(100), nullable=False)
    latitude = db.Column(db.Float, nullable=False)
    longitude = db.Column(db.Float, nullable=False)

    risk_level = db.Column(
        db.String(20),
        default="LOW"  # Risk
    )

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.now()
    )

    # Relationships
    env_data = db.relationship(
        "EnvData",
        backref="zone",
        lazy=True,
        cascade="all, delete-orphan"
    )

    distress_reports = db.relationship(
        "Distress",
        backref="zone",
        lazy=True
    )
