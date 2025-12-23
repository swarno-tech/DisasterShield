from flask import Flask
from .config.dev import DevConfig
from .extensions.db import db
from .extensions.migrate import migrate
from .extensions.socketio import socketio
from .routes import register_routes
from .jobs.risk_evaluator import start_scheduler

def create_app():
    app = Flask(__name__)
    app.config.from_object(DevConfig)

    db.init_app(app)
    migrate.init_app(app, db)
    socketio.init_app(app, cors_allowed_origins="*")

    register_routes(app)
    start_scheduler(app)

    return app
