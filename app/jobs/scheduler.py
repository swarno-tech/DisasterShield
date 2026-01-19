from apscheduler.schedulers.background import BackgroundScheduler
from app.jobs.risk_evaluator_job import run_risk_evaluation

scheduler = BackgroundScheduler()

def init_scheduler(app):
    def job_wrapper():
        with app.app_context():
            run_risk_evaluation()

    scheduler.add_job(
        job_wrapper,
        trigger="interval",
        minutes=10,
        id="risk_evaluation_job",
        replace_existing=True,
    )

    scheduler.start()
