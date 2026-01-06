import numpy as np

FEATURE_COLUMNS = [
    "rainfall",
    "river_discharge",
    "water_level",
    "humidity",
    "temperature",
]


def prepare_lstm_input(env_data_records, scaler, timesteps=6):

    if len(env_data_records) < timesteps:
        raise ValueError("Not enough data for LSTM prediction")

    recent_data = env_data_records[-timesteps:]

    X = []
    for r in recent_data:
        if isinstance(r, dict):
            row = [r[c] for c in FEATURE_COLUMNS]
        else:
            row = [
                r.rainfall,
                r.river_discharge,
                r.water_level,
                r.humidity,
                r.temperature,
            ]
        X.append(row)

    X = np.array(X, dtype=float)
    X_scaled = scaler.transform(X)

    return X_scaled.reshape(1, timesteps, len(FEATURE_COLUMNS))
