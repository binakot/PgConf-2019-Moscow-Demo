INSERT INTO devices (id, serial)
SELECT
    generate_series(1, 100)::INTEGER AS id,
    md5(random()::TEXT) AS serial
ON CONFLICT DO NOTHING;

INSERT INTO telemetries (
    device_id, receive_time, fix_time, valid,
    latitude, longitude, altitude, speed, course,
    analog, temperature, attributes
)
SELECT
    floor(random() * 100 + 1)::INTEGER AS device_id,
    now() - '1 day'::INTERVAL * round(random() * 30) AS receive_time,
    now() - '1 day'::INTERVAL * round(random() * 365) AS fix_time,
    random() > 0.1 AS valid,
    random() * 180 - 90 AS latitude,
    random() * 360 - 180 AS longitude,
    CASE WHEN random() > 0.25 THEN round(random() * 100)::SMALLINT ELSE NULL END AS altitude,
    CASE WHEN random() > 0.25 THEN round(random() * 180)::SMALLINT ELSE NULL END AS speed,
    CASE WHEN random() > 0.25 THEN round(random() * 360)::SMALLINT ELSE NULL END AS course,
    ARRAY[round(random() * 24000)::INTEGER, NULL] AS analog,
    ARRAY[round(random() * 100)::REAL, NULL, round(random() * 200)::REAL, NULL] AS temperature,
    CASE WHEN random() > 0.9 THEN ('{"hdop":' || round(random() * 10)::INTEGER || '}')::JSONB ELSE '{}'::JSONB END AS attributes
FROM generate_series(1, 100000)
ON CONFLICT DO NOTHING;

ANALYZE;
