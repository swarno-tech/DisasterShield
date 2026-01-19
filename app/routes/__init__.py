from .zone_routes import zone_bp
from .env_data_routes import env_data_bp
from .risk_routes import risk_bp
from .distress_routes import distress_bp
from .resource_routes import resource_bp
from .dispatch_routes import dispatch_bp
from .user_routes import user_bp
from .demo_routes import alert_bp  


def register_routes(app):
    app.register_blueprint(zone_bp, url_prefix="/api/zones")
    app.register_blueprint(env_data_bp, url_prefix="/api/env_data")
    app.register_blueprint(risk_bp, url_prefix="/api/risk")
    app.register_blueprint(distress_bp, url_prefix="/api/distress")
    app.register_blueprint(resource_bp, url_prefix="/api/resources")
    app.register_blueprint(dispatch_bp, url_prefix="/api/dispatch")
    app.register_blueprint(user_bp, url_prefix="/api/users")
    app.register_blueprint(alert_bp, url_prefix="/api/alert")