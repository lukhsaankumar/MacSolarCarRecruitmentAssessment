
# Part 2 Requirement: Use Python 3.11+ as the base image
FROM python:3.11-slim

# Best practices: Prevent Python from writing .pyc files and buffer logs for containerized apps
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set a working directory for the application
WORKDIR /app

# Install system dependencies (optional but good for package compatibility)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Part 2 Requirement: Handle requirements.txt with all necessary dependencies
# Copy dependency list first to leverage Docker layer caching
COPY requirements.txt /app/requirements.txt

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy the rest of the application code (main.py and other files)
COPY . /app

# Part 2 Requirement: Expose port 8000 so localhost:8000 hits the dockerized API
EXPOSE 8000

# Part 2 Requirement: Containerized API works the same as local version
# Start the FastAPI app with Uvicorn on 0.0.0.0:8000 to accept external connections
# main:app refers to the FastAPI instance 'app' in main.py file
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
