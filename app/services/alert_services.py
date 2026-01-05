import os
import requests
from datetime import datetime
from flask import current_app
from twilio.rest import Client

# -------- TELEGRAM CONFIG --------
TELEGRAM_BOT_TOKEN = os.getenv("TELEGRAM_BOT_TOKEN")
TELEGRAM_CHAT_ID = os.getenv("TELEGRAM_CHAT_ID")

# -------- TWILIO CONFIG --------
TWILIO_ACCOUNT_SID = os.getenv("TWILIO_ACCOUNT_SID")
TWILIO_AUTH_TOKEN = os.getenv("TWILIO_AUTH_TOKEN")
TWILIO_FROM_NUMBER = os.getenv("TWILIO_FROM_NUMBER")
ALERT_PHONE_NUMBER = os.getenv("ALERT_PHONE_NUMBER")

# -------- MAIN ENTRY --------
def trigger_alert(zone):
    message = format_alert(zone)

    send_telegram(message)
    send_sms(message)

# -------- MESSAGE FORMAT --------
def format_alert(zone):
    return (
        "DISASTER RISK ALERT !!!! Please evacuate the area and go to a safe place as soon as possible\n\n"
        f"📍 Zone: {zone.name}\n"
        f"⚠️ Risk Level: {zone.risk_level}\n"
        f"🕒 Time: {datetime.utcnow()} UTC\n\n"
        "Immediate inspection required."
    )

# -------- TELEGRAM --------
def send_telegram(message):
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage"
    payload = {
        "chat_id": TELEGRAM_CHAT_ID,
        "text": message
    }

    response = requests.post(url, json=payload)
    if response.status_code != 200:
        current_app.logger.error(
            f"Telegram failed: {response.text}"
        )

# -------- TWILIO SMS --------
def send_sms(message):
    client = Client(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
    client.messages.create(
        body=message,
        from_=TWILIO_FROM_NUMBER,
        to=ALERT_PHONE_NUMBER
    )
