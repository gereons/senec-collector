[![Continuous integration](https://github.com/solectrus/senec-collector/actions/workflows/push.yml/badge.svg)](https://github.com/solectrus/senec-collector/actions/workflows/push.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/ae0d21c0c4eb9c430505/maintainability)](https://codeclimate.com/github/solectrus/senec-collector/maintainability)
[![wakatime](https://wakatime.com/badge/user/697af4f5-617a-446d-ba58-407e7f3e0243/project/e8426066-7e79-40d8-8d8b-583dd965720a.svg)](https://wakatime.com/badge/user/697af4f5-617a-446d-ba58-407e7f3e0243/project/e8426066-7e79-40d8-8d8b-583dd965720a)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ae0d21c0c4eb9c430505/test_coverage)](https://codeclimate.com/github/solectrus/senec-collector/test_coverage)

# SENEC collector

Collect data from SENEC photovoltaics and push it to InfluxDB 2

Tested with SENEC.Home V3 hybrid duo

## Requirements

Linux machine with Docker installed

Tested on:

- Raspberry Pi 4 Model B on Raspbian GNU/Linux 10 (buster) and 11 (bullseye)
- Synology NAS DS220+ on DSM 7.1

## Getting started

1. Make sure that you have a SENEC device in your house that can be reached via the LAN and an in-house Linux box

2. Make sure your InfluxDB2 database is ready (not subject of this README)

3. Prepare an `.env` file (see `.env.example`)

4. Run the Docker container on your Linux box:

   ```bash
   docker compose up
   ```

The Docker image support multiple platforms: `linux/amd64`, `linux/arm64`, `linux/arm/v7`

## Build Docker image by yourself

Example for Raspberry Pi:

```bash
docker buildx build --platform linux/arm/v7 -t senec-collector .
```

## License

Copyright (c) 2020-2024 Georg Ledermann, released under the MIT License
