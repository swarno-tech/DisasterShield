from app.extensions import db
from app.models.resource import Resource
from app.models.dispatch import Dispatch
from app.services.routing_service import get_eta_minutes
from app.utils.geo import haversine_distance


def dispatch_nearest_ambulance(distress):

    # Get available ambulances
    resources = Resource.query.filter_by(is_available=True).all()
    if not resources:
        return None

    # Find nearest ambulance
    nearest = None
    min_distance = float("inf")

    for resource in resources:
        distance = haversine_distance(
            distress.latitude,
            distress.longitude,
            resource.latitude,
            resource.longitude
        )

        if distance < min_distance:
            min_distance = distance
            nearest = resource

    # Calculate ETA
    try:
        eta_minutes = get_eta_minutes(
            nearest.latitude,
            nearest.longitude,
            distress.latitude,
            distress.longitude
        )
    except Exception:
        eta_minutes = int((min_distance / 40) * 60)

    dispatch = Dispatch(
        distress_id=distress.id,
        resource_id=nearest.id,
        eta_minutes=eta_minutes,
        status="Dispatched"
    )

    nearest.is_available = False
    distress.status = "DISPATCHED"

    db.session.add(dispatch)
    db.session.commit()

    return dispatch
