# McMaster Solar Car Recruitment Assessment - Lukhsaan Elankumaran | 400522860 | elankuml

## Implementation

FastAPI-based REST API for sorting numbers with input validation and Docker containerization.

**main.py** - FastAPI application with POST endpoint `/sorted-numbers` that accepts integer arrays and returns both original and sorted versions. Uses Pydantic for validation and rejects invalid data types including booleans, strings, and floats.

**Dockerfile** - Python 3.11-slim container with proper dependency management and port 8000 exposure.

## Usage

```bash
# Build the Docker image
docker build -t solar-car-api .

# Run the container
docker run -p 8000:8000 solar-car-api

# Test the API
curl -X POST http://localhost:8000/sorted-numbers \
  -H "Content-Type: application/json" \
  -d '{"numbers": [45, 23, 78, 12, 91, 34, 67, 89, 56, 3]}'
```

## Test Suite

To run the comprehensive test cases:

```bash
sudo apt install jq
chmod +x testcases.sh
./testcases.sh
```