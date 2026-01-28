import os
import requests
from datetime import datetime
from flask import current_app
from twilio.rest import Client

from app.extensions import db
from app.models.alert_response import AlertResponse
from app.services.alert_simulator import simulate_alert_responses
from app.models.user import User

# -------- TWILIO CONFIG (secrets only) --------
TWILIO_ACCOUNT_SID = os.getenv("TWILIO_ACCOUNT_SID")
TWILIO_AUTH_TOKEN = os.getenv("TWILIO_AUTH_TOKEN")
TWILIO_FROM_NUMBER = os.getenv("TWILIO_FROM_NUMBER")

# -------- TELEGRAM CONFIG (secret only) --------
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")
TELEGRAM_CHAT_ID = os.getenv("TELEGRAM_CHAT_ID")
ALERT_PHONE_NUMBER = os.getenv("ALERT_PHONE_NUMBER")


# -------- MAIN ENTRY --------
def trigger_alert(zone):
    """
    Send alert to all users belonging to a zone
    """
    users = User.query.filter_by(zone_id=zone.id, is_active=True).all()

    if not users:
        current_app.logger.warning(
            f"No users found for zone {zone.name}"
        )
        return

    db.session.commit()

    message = format_alert(zone)
    msg = twilio_alert()

    for user in users:
        # if user.phone_number:
        #     try:
        #         send_sms(demo_phone, message)
        #     except Exception as e:
        #         current_app.logger.error(
        #             f"Failed to send SMS to {user.phone_number}: {str(e)}"
        #         )

        if user.telegram_chat_id:
            send_telegram(TELEGRAM_CHAT_ID, message)
    send_sms(ALERT_PHONE_NUMBER, msg)

    simulate_alert_responses(zone)


# -------- MESSAGE FORMAT --------
def format_alert(zone):
    return (
        "🚨 FLOOD RISK ALERT 🚨\n\n"
        f"📍 Zone: {zone.name}\n"
        f"⚠️ Risk Level: {zone.risk_level}\n"
        f"🕒 Time: {datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')} UTC\n\n"
        "Reply:\n"
        "SAFE - if you are safe\n"
        "HELP - if you need emergency assistance"
    )

def twilio_alert():
    return (
        "🚨 FLOOD RISK ALERT 🚨\n\n"
    )

# -------- TELEGRAM --------
def send_telegram(chat_id, message):
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage"

    payload = {
        "chat_id": chat_id,
        "text": message
    }

    response = requests.post(url, json=payload)

    if response.status_code != 200:
        current_app.logger.error(
            f"Telegram failed for chat {chat_id}: {response.text}"
        )


# -------- TWILIO SMS --------
def send_sms(to_number, message):
    client = Client(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)

    client.messages.create(
        body=message,
        from_=TWILIO_FROM_NUMBER,
        to=to_number
    )