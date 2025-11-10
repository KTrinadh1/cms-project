# Use the official lightweight Python image as the base
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Install system dependencies for pyodbc and SQL Server connectivity
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl gnupg2 apt-transport-https unixodbc unixodbc-dev && \
    mkdir -p /etc/apt/keyrings && \
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg && \
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" \
        > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools18 && \
    apt-get install -y gcc g++ libffi-dev libssl-dev libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Copy the entire project folder into the container
COPY . /app

# Explicitly copy application.py in case it was ignored
COPY application.py /app/application.py

# Install Python dependencies (from requirements.txt)
# The "--no-cache-dir" flag keeps the image size smaller
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 5000 for Flask web traffic
EXPOSE 5000

# Add a health check for observability (Azure or Docker will restart container if it fails)
# "curl" checks if the Flask app home route ("/") responds
HEALTHCHECK CMD curl --fail http://localhost:5000 || exit 1

# Optional: Log startup message (helps identify if container runs successfully)
# This adds clarity to Azure App Service log streams
RUN echo "Docker image for Flask CMS app built successfully"

# Define the command to start the Flask application
CMD ["python", "application.py"]
