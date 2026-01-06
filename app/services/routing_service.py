import requests
from flask import current_app


def get_eta_minutes(src_lat, src_lon, dest_lat, dest_lon):
    base_url = current_app.config["OSRM_BASE_URL"]

    url = (
        f"{base_url}/route/v1/driving/"
        f"{src_lon},{src_lat};{dest_lon},{dest_lat}"
        "?overview=false"
    )

    res = requests.get(url, timeout=5)
    data = res.json()

    duration_sec = data["routes"][0]["duration"]
    return int(duration_sec / 60)
