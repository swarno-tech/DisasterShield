from app.app import create_app
from app.extensions import db
from app.models.zone import Zone
from app.models.user import User
from app.models.resource import Resource


def seed_zones():
    zones = [
        {
            "name": "Balasore (Baleshwar)",
            "latitude": 21.4926,
            "longitude": 86.9334,
        },
        {
            "name": "Bhadrak",
            "latitude": 21.051182,
            "longitude": 86.485748,
        },
        {
            "name": "Kendrapara",
            "latitude": 20.54752,
            "longitude": 86.52962,
        },
        {
            "name": "Puri",
            "latitude": 19.817743,
            "longitude": 85.828629,
        },
        {
            "name": "Jajapur",
            "latitude": 20.82779,
            "longitude": 86.37984,
        },
        {
            "name": "Cuttack",
            "latitude": 20.37007,
            "longitude": 85.46973,
        },
        {
            "name": "Jagatsinghapur",
            "latitude": 20.2549,
            "longitude": 86.1706,
        },
        {
            "name": "Khurdha",
            "latitude": 20.194223,
            "longitude": 85.625725,
        },
        {
            "name": "Ganjam",
            "latitude": 19.387388,
            "longitude": 85.051544,
        },
        {
            "name": "Kendujhar",
            "latitude": 21.6393,
            "longitude": 85.6055,
        },
    ]

    for z in zones:
        exists = Zone.query.filter_by(name=z["name"]).first()
        if not exists:
            zone = Zone(
                name=z["name"],
                latitude=z["latitude"],
                longitude=z["longitude"],
                risk_level="LOW",
            )
            db.session.add(zone)

    db.session.commit()
    print("Zones seeded")

def seed_users():
    zones = Zone.query.all()
    base_telegram_id = 923312153

    for zone in zones:
        for i in range(2):  # 2 users per zone
            phone = f"+91{9000000000 + zone.id*10 + i}"

            if User.query.filter_by(phone_number=phone).first():
                continue

            users = User(
                name=f"Resident {i+1} of {zone.name}",
                phone_number=phone,   # demo
                telegram_chat_id=base_telegram_id + (zone.id * 100) + i,
                latitude=zone.latitude,
                longitude=zone.longitude,
                zone_id=zone.id,
            )
            db.session.add(users)

    db.session.commit()
    print(" Users seeded")


def seed_resources():
    ambulances = [
        {
            "name": "Ambulance Balasore-1",
            "latitude": 21.4978,
            "longitude": 86.9281,
        },
        {
            "name": "Ambulance Balasore-2",
            "latitude": 21.4889,
            "longitude": 86.9402,
        },
        {
            "name": "Ambulance Balasore-3",
            "latitude": 21.5031,
            "longitude": 86.9196,
        },
        {
            "name": "Ambulance Kendrapara-1",
            "latitude": 20.5534,
            "longitude": 86.5251,
        },
        {
            "name": "Ambulance Kendrapara-2",
            "latitude": 20.5427,
            "longitude": 86.5379,
        },
        {
            "name": "Ambulance Puri-1",
            "latitude": 19.8209,
            "longitude": 85.8234,
        },
        {
            "name": "Ambulance Puri-2",
            "latitude": 19.8098,
            "longitude": 85.8352,
        },
        {
            "name": "Ambulance Puri-3",
            "latitude": 19.8284,
            "longitude": 85.8176,
        },
        {
            "name": "Ambulance Jajapur-1",
            "latitude": 20.8321,
            "longitude": 86.3732,
        },
        {
            "name": "Ambulance Jajapur-2",
            "latitude": 20.8214,
            "longitude": 86.3891,
        },
        {
            "name": "Ambulance Cuttack-1",
            "latitude": 20.3748,
            "longitude": 85.4652,
        },
        {
            "name": "Ambulance Cuttack-2",
            "latitude": 20.3615,
            "longitude": 85.4803,
        },
        {
            "name": "Ambulance Cuttack-3",
            "latitude": 20.3812,
            "longitude": 85.4558,
        },
        {
            "name": "Ambulance Jagatsinghapur-1",
            "latitude": 20.2593,
            "longitude": 86.1664,
        },
        {
            "name": "Ambulance Jagatsinghapur-2",
            "latitude": 20.2476,
            "longitude": 86.1789,
        },
        {
            "name": "Ambulance Khurdha-1",
            "latitude": 20.1989,
            "longitude": 85.6214,
        },
        {
            "name": "Ambulance Khurdha-2",
            "latitude": 20.1857,
            "longitude": 85.6372,
        },
        {
            "name": "Ambulance Ganjam-1",
            "latitude": 19.3926,
            "longitude": 85.0468,
        },
        {
            "name": "Ambulance Ganjam-2",
            "latitude": 19.3781,
            "longitude": 85.0613,
        },
        {
            "name": "Ambulance Kendujhar-1",
            "latitude": 21.6441,
            "longitude": 85.6009,
        },
        {
            "name": "Ambulance Kendujhar-2",
            "latitude": 21.6318,
            "longitude": 85.6172,
        },
    ]

    for a in ambulances:
        exists = Resource.query.filter_by(name=a["name"]).first()
        if not exists:
            ambulance = Resource(
                name=a["name"],
                latitude=a["latitude"],
                longitude=a["longitude"],
                is_available=True,
            )
            db.session.add(ambulance)

    db.session.commit()
    print("Ambulance resources seeded")


def run_seed():
    app = create_app()
    with app.app_context():
        seed_zones()
        seed_users()
        seed_resources()


if __name__ == "__main__":
    run_seed()
