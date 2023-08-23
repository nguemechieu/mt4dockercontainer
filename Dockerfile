# Use a base image with wine already installed (you can replace this with a suitable wine image)
FROM my-wine-image:latest

# Update package repositories and install additional tools
RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

# Copy your script to the container
COPY mt4ubuntu.sh /app/mt4ubuntu.sh

# Set executable permissions on the script
RUN chmod +x /app/mt4ubuntu.sh

# Set a default working directory
WORKDIR /app

# Command to run when the container starts
CMD ["/bin/bash"]
