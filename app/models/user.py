from app.extensions.db import db


class User(db.Model):
    __tablename__ = "users"

    id = db.Column(db.Integer, primary_key=True)

    name = db.Column(db.String(100))

    phone_number = db.Column(db.String(20), unique=True, nullable=True)
    telegram_chat_id = db.Column(db.String(50), unique=True, nullable=True)

    latitude = db.Column(db.Float, nullable=False)
    longitude = db.Column(db.Float, nullable=False)

    zone_id = db.Column(
        db.Integer,
        db.ForeignKey("zones.id"),
        nullable=False
    )

    is_active = db.Column(db.Boolean, default=True)

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.now()
    )
