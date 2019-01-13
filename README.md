# 🐘🐘🐘 PgConf.Russia 2019 🐘🐘🐘

## Demo Project

This is the demo for my presentation on [PgConf.Russia 2019](https://pgconf.ru/2019) in Moscow.

Here is the announcement of my speech: [https://pgconf.ru/2019/242909](https://pgconf.ru/2019/242909).

The database contains a schema for demonstration of the idea 
to work with telematics and telemetry via PostgeSQL.

### Getting Started

To run this demo you need `Docker` with `docker-compose`.

Just type the command `docker-compose up -d` from this folder.
After all type the `docker-compose down` to stop the demo.

### Content

There are the stack of two applications via docker-compose yaml file with:

* Postgres 11.1 + PostGIS 2.5.1 + TimescaleDB 1.1.1

* PgAdmin 4 (`binakot@pgconf.ru / PgConfIsAwesome` on [http://localhost:5433](http://localhost:5433))

To get access from `pgAdmin4` you need to use next connection settings:

```yaml
Host: postgres
Port: 5432
MaintenanceDB: postgres
Username: postgres
Password: postgres
```
