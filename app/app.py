from flask import Flask
from flask_cors import CORS
from app.config import get_config
from app.extensions import db, migrate
from app.extensions.ml import load_ml_assets
from app.routes import register_routes



def create_app():
    app = Flask(__name__)
    app.config.from_object(get_config())

    CORS(app)

    db.init_app(app)
    migrate.init_app(app, db)

    with app.app_context():
        load_ml_assets(app)
    
    register_routes(app)

    @app.route("/health", methods=["GET"])
    def health():
        return {"status": "OK", "service": "DisasterShield"}, 200

    @app.errorhandler(404)
    def not_found(e):
        return {"error": "Not Found"}, 404

    return app
