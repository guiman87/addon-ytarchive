# Ytarchive Home Assistant Add-on Overview

This repository contains a custom Home Assistant add-on named **ytarchive**, which leverages:
- **MQTT** for starting and stopping recordings.
- **ytarchive** for downloading YouTube livestreams.
- **Docker** for bundling the add-on environment.

## Key Files and Functions

- **config.yaml**: Defines metadata (name, version, schema) for the add-on.
- **build.yaml**: Specifies build instructions and target architectures.
- **Dockerfile**: Installs dependencies and places ytarchive binaries.
- **rootfs** folder: Contains scripts and services to start or stop recordings via MQTT messages.

## Usage

1. Ensure **MQTT service** is configured in Home Assistant.
2. Publish a valid YouTube link to `homeassistant/ytarchive/run` to start a recording.
3. Publish `stop` to `homeassistant/ytarchive/stop` to finalize and save the stream.

## Repository Metadata

- **LICENSE**: Apache License 2.0.
- **README.md**: Original blueprint instructions and references.
- **Workflows**: GitHub Actions for linting, building, and dependency updates (in `.github/workflows`).
