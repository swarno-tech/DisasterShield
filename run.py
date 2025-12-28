import os
from app import create_app
APP_ENV = os.getenv("APP_ENV", "development")

if APP_ENV == "prod":
    app = create_app("app.config.prod.ProdConfig")
else:
    app = create_app("app.config.dev.DevConfig")

if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=int(os.getenv("PORT", 5000)),
        debug=app.config["DEBUG"]
    )
