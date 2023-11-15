# Use ubuntu-minimal as base image
FROM ubuntu:20.04

# Avoid tzdata asking for geographic location
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /run/sshd

# Expose port 22 for SSH
EXPOSE 22

# Define the volume for /home
VOLUME /home

# Copy the startup script into the image
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Run the startup script in the foreground
CMD ["/start.sh"]
