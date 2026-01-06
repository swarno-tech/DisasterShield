from app.extensions.db import db


class EnvData(db.Model):
    __tablename__ = "env_data"

    id = db.Column(db.Integer, primary_key=True)

    zone_id = db.Column(
        db.Integer,
        db.ForeignKey("zones.id"),
        nullable=False
    )

    rainfall = db.Column(db.Float, nullable=False)
    river_discharge = db.Column(db.Float, nullable=False)
    water_level = db.Column(db.Float, nullable=False)
    humidity = db.Column(db.Float, nullable=False)
    temperature = db.Column(db.Float, nullable=False)

    collected_at = db.Column(
        db.DateTime,
        server_default=db.func.now()
    )
