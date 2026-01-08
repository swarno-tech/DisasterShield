from flask_apscheduler import APScheduler
from app.jobs.risk_evaluator_job import run_risk_evaluation

scheduler = APScheduler()

def init_scheduler(app):
    scheduler.init_app(app)

    scheduler.add_job(
        id="risk_evaluation_job",
        func=run_risk_evaluation,
        trigger="interval",
        minutes=10,  # every 10 minutes
        replace_existing=True
    )

    scheduler.start()
