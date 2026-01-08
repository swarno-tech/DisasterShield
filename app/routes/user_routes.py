from flask import Blueprint, request, jsonify
from app.extensions import db
from app.models.user import User

user_bp = Blueprint("users", __name__, url_prefix="/api/users")

# GET all users
@user_bp.route("", methods=["GET"])
def list_users():
    users = User.query.all()

    return jsonify([
        {
            "id": u.id,
            "name": u.name,
            "phone_number": u.phone_number,
            "telegram_chat_id": u.telegram_chat_id,
            "latitude": u.latitude,
            "longitude": u.longitude,
            "zone_id": u.zone_id,
            "is_active": u.is_active,
        }
        for u in users
    ]), 200


# GET single user by ID

@user_bp.route("/<int:user_id>", methods=["GET"])
def get_user(user_id):
    user = User.query.get_or_404(user_id)

    return jsonify({
        "id": user.id,
        "name": user.name,
        "phone_number": user.phone_number,
        "telegram_chat_id": user.telegram_chat_id,
        "latitude": user.latitude,
        "longitude": user.longitude,
        "zone_id": user.zone_id,
        "is_active": user.is_active,
    }), 200


# CREATE user
@user_bp.route("", methods=["POST"])
def create_user():
    data = request.get_json()

    if not data or "name" not in data or "phone_number" not in data or "zone_id" not in data:
        return {"error": "Missing required fields"}, 400

    if User.query.filter_by(phone_number=data["phone_number"]).first():
        return {"error": "User with this phone number already exists"}, 409

    user = User(
        name=data["name"],
        phone_number=data["phone_number"],
        telegram_chat_id=data.get("telegram_chat_id"),
        latitude=data.get("latitude"),
        longitude=data.get("longitude"),
        zone_id=data["zone_id"],
        is_active=True,
    )

    db.session.add(user)
    db.session.commit()

    return {
        "message": "User created successfully",
        "user_id": user.id
    }, 201


# UPDATE user
@user_bp.route("/<int:user_id>", methods=["PUT"])
def update_user(user_id):
    user = User.query.get_or_404(user_id)
    data = request.get_json()

    user.name = data.get("name", user.name)
    user.phone_number = data.get("phone_number", user.phone_number)
    user.telegram_chat_id = data.get("telegram_chat_id", user.telegram_chat_id)
    user.latitude = data.get("latitude", user.latitude)
    user.longitude = data.get("longitude", user.longitude)
    user.zone_id = data.get("zone_id", user.zone_id)
    user.is_active = data.get("is_active", user.is_active)

    db.session.commit()

    return {"message": "User updated successfully"}, 200


# DEACTIVATE user
@user_bp.route("/<int:user_id>", methods=["DELETE"])
def deactivate_user(user_id):
    user = User.query.get_or_404(user_id)

    user.is_active = False
    db.session.commit()

    return {"message": "User deactivated successfully"}, 200
