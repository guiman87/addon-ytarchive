# Home Assistant Add-on: ytarchive

Record YouTube livestreams via [ytarchive](https://github.com/Kethsar/ytarchive). It publishes MQTT topics to start or stop recordings.

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]
![Supports i386 Architecture][i386-shield]

## Installation
1. Add this repository in the Home Assistant Supervisor Add-on Store.
2. Install the **ytarchive** add-on.
3. Configure MQTT in Home Assistant so the add-on can publish and subscribe.
4. Start the add-on.

## Usage
1. Publish a YouTube URL to start recording:  
   - Topic: `homeassistant/ytarchive/run`  
   - Example payload:  
     ```
     https://www.youtube.com/watch?v=STREAM_ID
     ```
2. Publish `stop` to end recording:  
   - Topic: `homeassistant/ytarchive/stop`
   - Example payload:
   ```
   stop
   ```

## Logs
- View logs in the add-on logs panel.
- Recordings save under `/share/ytarchive`.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg