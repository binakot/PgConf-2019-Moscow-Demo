SELECT time_bucket('1 day', fix_time) AS day,
    avg(speed) AS "avg",
    min(speed) AS "min",
    max(speed) AS "max"
  FROM telemetries
  WHERE device_id = 1
    AND fix_time > now() - interval '1 month'
  GROUP BY day
  ORDER BY day ASC;

SELECT time_bucket('1 day', fix_time) AS day,
    COUNT(*) AS in_krasnodar_area
  FROM telemetries
  WHERE ST_Within(location, ST_Buffer(ST_MakePoint(38.976008, 45.040207)::geography, 100000)::geometry)
  GROUP BY day
  ORDER BY day DESC;

