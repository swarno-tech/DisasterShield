import requests
from datetime import datetime

from flask import current_app

from app.extensions.db import db
from app.models.env_data import EnvData
from app.models.zone import Zone


def derive_hydrology(rainfall_mm: float):

    # Derived formula
    river_discharge = round(rainfall_mm * 4.5, 2)  # m³/s

    water_level = round(1.5 + (river_discharge / 100), 2)  # meters

    return river_discharge, water_level


def fetch_weather(lat: float, lon: float):

    api_key = current_app.config["OPENWEATHER_API_KEY"]

    url = (
        "https://api.openweathermap.org/data/2.5/weather"
        f"?lat={lat}&lon={lon}&appid={api_key}&units=metric"
    )

    response = requests.get(url, timeout=10)
    response.raise_for_status()

    data = response.json()

    rainfall = data.get("rain", {}).get("1h", 0.0)  # mm
    humidity = data["main"]["humidity"]             # %
    temperature = data["main"]["temp"]              # °C

    return rainfall, humidity, temperature


def collect_env_data():
    """
    Collect environmental data for all zones
    and store it in the database.
    """

    zones = Zone.query.all()

    for zone in zones:
        try:
            # Fetching weather data
            rainfall, humidity, temperature = fetch_weather(
                zone.latitude,
                zone.longitude
            )

            # finding derived values
            river_discharge, water_level = derive_hydrology(rainfall)

            # storing env data
            env_data = EnvData(
                zone_id=zone.id,
                rainfall=rainfall,
                river_discharge=river_discharge,
                water_level=water_level,
                humidity=humidity,
                temperature=temperature,
                recorded_at=datetime.utcnow()
            )

            db.session.add(env_data)

        except Exception as e:
            current_app.logger.error(
                f"Env data collection failed for zone {zone.id}: {e}"
            )

    db.session.commit()
