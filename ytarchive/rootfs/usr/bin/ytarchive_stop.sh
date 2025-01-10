#!/command/with-contenv bashio
# ==============================================================================
# Stop recording YouTube livestreams
# ==============================================================================

bashio::log.info "Listening for MQTT messages to stop recording..."

# Get MQTT service details
MQTT_HOST=$(bashio::services mqtt "host")
MQTT_USER=$(bashio::services mqtt "username")
MQTT_PASSWORD=$(bashio::services mqtt "password")

MQTT_TOPIC_STOP="homeassistant/ytarchive/stop"
PID_FILE="/tmp/ytarchive_download.pid"

mosquitto_sub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASSWORD" -t "$MQTT_TOPIC_STOP" | while read -r message; do
    if [[ "$message" == "stop" ]]; then
        if [ -f "$PID_FILE" ]; then
            CURRENT_DOWNLOAD_PID=$(cat "$PID_FILE")
            bashio::log.info "Stopping current recording (PID: $CURRENT_DOWNLOAD_PID)"
            kill -SIGINT "$CURRENT_DOWNLOAD_PID" 2>/dev/null
            wait "$CURRENT_DOWNLOAD_PID" 2>/dev/null
            rm -f "$PID_FILE"
            bashio::log.info "Recording stopped and file finalized."
        else
            bashio::log.warning "No active recording to stop."
        fi
    fi
done
 
