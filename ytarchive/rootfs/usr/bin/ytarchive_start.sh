#!/command/with-contenv bashio
# ==============================================================================
# Start recording YouTube livestreams using ytarchive
# ==============================================================================

bashio::log.info "Listening for MQTT messages to start recording..."

# Get MQTT service details
MQTT_HOST=$(bashio::services mqtt "host")
MQTT_USER=$(bashio::services mqtt "username")
MQTT_PASSWORD=$(bashio::services mqtt "password")

MQTT_TOPIC_START="homeassistant/ytarchive/run"
PID_FILE="/tmp/ytarchive_download.pid"

mosquitto_sub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASSWORD" -t "$MQTT_TOPIC_START" | while read -r youtube_url; do
    if [ -f "$PID_FILE" ]; then
        bashio::log.warning "A download is already in progress. Please stop it before starting a new one."
        continue
    fi

    OUTPUT_DIR="/share/ytarchive"
    mkdir -p "$OUTPUT_DIR"

    if [ -z "$youtube_url" ]; then
        bashio::log.error "No URL provided. Skipping."
        continue
    fi

    bashio::log.info "Starting download for: $youtube_url"
    mosquitto_pub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASSWORD" -t "ytarchive/status" -m "Downloading started for: $youtube_url"

    ytarchive -q -w --no-wait --merge --no-frag-files --vp9 -o "${OUTPUT_DIR}/%(title)s" "$youtube_url" "720p/best" &
    echo $! > "$PID_FILE"
    wait "$!"
    
    if [ $? -eq 0 ]; then
        bashio::log.info "Download completed for: $youtube_url"
        mosquitto_pub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASSWORD" -t "ytarchive/status" -m "Download completed and saved in: $OUTPUT_DIR"
    else
        bashio::log.error "Download interrupted for: $youtube_url"
        mosquitto_pub -h "$MQTT_HOST" -u "$MQTT_USER" -P "$MQTT_PASSWORD" -t "ytarchive/status" -m "Download interrupted for: $youtube_url"
    fi

    rm -f "$PID_FILE"
done
