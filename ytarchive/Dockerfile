ARG BUILD_FROM
FROM $BUILD_FROM

# Install dependencies
RUN apk add --no-cache \
    mosquitto-clients \
    python3 \
    py3-pip \
    py3-requests \
    py3-reportlab \
    py3-dateutil \
    py3-dbus \
    dbus \
    wget \
    bash \
    ffmpeg \
    unzip

# Download ytarchive
RUN wget https://github.com/Kethsar/ytarchive/releases/download/latest/ytarchive_linux_amd64.zip && \
    unzip ytarchive_linux_amd64.zip && \
    chmod +x ytarchive && \
    mv ytarchive /usr/local/bin/ && \
    rm ytarchive_linux_amd64.zip

# Copy rootfs content
COPY rootfs/ /

# Set correct permissions
RUN chmod a+x /etc/services.d/ytarchive-run/run \
    && chmod a+x /etc/services.d/ytarchive-stop/run \
    && chmod a+x /usr/bin/ytarchive_start.sh \
    && chmod a+x /usr/bin/ytarchive_stop.sh
