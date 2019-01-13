CREATE TABLE devices (
    id          SERIAL      PRIMARY KEY,
    serial      TEXT        NOT NULL UNIQUE
);

CREATE TABLE telemetries (
    device_id           INTEGER                  NOT NULL REFERENCES devices(id) ON DELETE CASCADE,
    receive_time        TIMESTAMPTZ              NOT NULL DEFAULT now(),
    fix_time            TIMESTAMPTZ              NOT NULL CHECK (fix_time < now() + INTERVAL '1 minute'),
    valid               BOOLEAN,
    latitude            DOUBLE PRECISION         NOT NULL CHECK (latitude > -90 AND latitude < 90),
    longitude           DOUBLE PRECISION         NOT NULL CHECK (longitude > -180 AND longitude < 180),
    location            GEOMETRY(POINT, 4326)    NOT NULL,
    altitude            SMALLINT,
    speed               SMALLINT,
    course              SMALLINT,
    analog              INTEGER[2]               NOT NULL DEFAULT ARRAY[NULL, NULL]::INTEGER[],
    temperature         REAL[4]                  NOT NULL DEFAULT ARRAY[NULL, NULL, NULL, NULL]::REAL[],
    attributes          JSONB                    NOT NULL DEFAULT '{}'::JSONB,

    CONSTRAINT telemetries_pkey PRIMARY KEY (device_id, fix_time)
);

CREATE FUNCTION calculate_telemetry_location() RETURNS trigger AS $$
    BEGIN
        NEW.location := ST_SetSRID(ST_Makepoint(NEW.longitude,NEW.latitude), 4326);
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER calculate_location BEFORE INSERT ON telemetries
    FOR EACH ROW EXECUTE PROCEDURE calculate_telemetry_location();

SELECT create_hypertable('telemetries', 'fix_time');
