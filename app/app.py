from flask import Flask
from flask_cors import CORS
from app.config import get_config
from app.extensions import db, migrate
from app.routes import register_routes
from app.extensions.ml import load_ml_assets
from app.jobs.scheduler import init_scheduler

def create_app():
    app = Flask(__name__)
    app.config.from_object(get_config())

    CORS(app)

    db.init_app(app)
    migrate.init_app(app, db)


    from app import models
    
    register_routes(app)

    @app.route("/api/health", methods=["GET"])
    def health():
        return {"status": "OK", "service": "DisasterShield"}, 200

    @app.errorhandler(404)
    def not_found(e):
        return {"error": "Not Found"}, 404
    
    if not app.config.get("SKIP_ML_LOAD", False):
        with app.app_context():
            load_ml_assets(app)
    
    if not app.config.get("DISABLE_SCHEDULER", False):
        init_scheduler(app)

    return app
