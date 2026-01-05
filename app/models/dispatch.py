from app.extensions.db import db


class Dispatch(db.Model):
    __tablename__ = "dispatches"

    id = db.Column(db.Integer, primary_key=True)

    distress_id = db.Column(
        db.Integer,
        db.ForeignKey("distress.id"),
        nullable=False
    )

    resource_id = db.Column(
        db.Integer,
        db.ForeignKey("resources.id"),
        nullable=False
    )

    eta_minutes = db.Column(db.Integer)

    status = db.Column(
        db.String(20),
        default="DISPATCH"
    )

    created_at = db.Column(
        db.DateTime,
        server_default=db.func.now()
    )
