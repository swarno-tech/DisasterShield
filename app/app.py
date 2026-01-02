from flask import Flask
from app.config import get_config
from app.extensions import db, migrate
from app.extensions.ml import load_ml_assets


def create_app():
    app = Flask(__name__)
    app.config.from_object(get_config())

    db.init_app(app)
    migrate.init_app(app, db)

    with app.app_context():
        load_ml_assets(app)

    return app
