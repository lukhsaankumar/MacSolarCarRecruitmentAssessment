# McMaster Solar Car Operations Team - Development Challenge

## Implementation Summary

This project implements a FastAPI-based REST API for sorting numbers with comprehensive error handling and Docker containerization.

**Technologies Used:**
- FastAPI for the REST API framework
- Pydantic for request/response validation
- Uvicorn as the ASGI server
- Docker for containerization

**Features:**
- Single POST endpoint `/sorted-numbers` for sorting integer arrays
- Comprehensive input validation (rejects strings, floats, booleans, null values)
- Returns both original and sorted arrays in JSON format
- Health check endpoint at `/` 
- Proper HTTP status codes (200 for success, 422 for validation errors)
- Docker support with Python 3.11-slim base image

## Part 1: API Endpoint for Sorted Numbers

Create an API endpoint that takes a list of numbers and returns them sorted using either Flask or FastAPI.

### Requirements:
1. Create an API application with a single endpoint `/sorted-numbers`
2. The endpoint should accept GET requests
3. Should accept a list of integers in the request body
4. Return the numbers in both original and sorted order
5. Return the response in JSON format
6. The API should be as safe as possible, validate the input handle errors gracefully. 
7. Errors should occur when `numbers` is not in the request body OR `numbers` is not a list of integers. 


### Example Request:
```json
{
    "numbers": [45, 23, 78, 12, 91, 34, 67, 89, 56, 3]
}
```

### Expected Response Format:
```json
{
    "original_numbers": [45, 23, 78, 12, 91, 34, 67, 89, 56, 3],
    "sorted_numbers": [3, 12, 23, 34, 45, 56, 67, 78, 89, 91]
}
```

### Instructions:
1. Choose either Flask or FastAPI for your implementation
2. Implement the API application in a file called `main.py`
3. Make sure the server runs on `localhost:8000` (or specify a different port if needed)

To test the application, you can use the requests module or curl commands:

## Part 2: Dockerize the Application

Now that you have a working API, let's containerize it using Docker to make it easily deployable and portable.

### Requirements:
1. Edit the `Dockerfile` to build the image
3. Expose port 8000 so that making a request to `localhost:8000` will hit the dockerized API
- Use Python 3.11+ as the base image (already in the Dockerfile)
- You will likely need to create a `requirements.txt` file with all necessary dependencies
- The containerized API works the same as the local version

### Example Commands that should build and run the dockerized API:
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

## Running the Application

### Option 1: Run Locally
```bash
# Install dependencies
pip install -r requirements.txt

# Run the API server
python main.py
```

The API will be available at `http://localhost:8000`

### Option 2: Run with Docker
```bash
# Build the Docker image
docker build -t solar-car-api .

# Run the container
docker run -p 8000:8000 solar-car-api
```

The API will be available at `http://localhost:8000`

## Testing

### Manual Testing
```bash
# Test the main endpoint
curl -X POST http://localhost:8000/sorted-numbers \
  -H "Content-Type: application/json" \
  -d '{"numbers": [45, 23, 78, 12, 91, 34, 67, 89, 56, 3]}'

# Health check
curl http://localhost:8000/
```

### Automated Testing (Optional)
A comprehensive test suite is provided in `testcases.sh`:

```bash
# Make executable and run tests
chmod +x testcases.sh
./testcases.sh
```

The test suite includes:
- 10 valid test cases (various number combinations)
- 12 error test cases (validation scenarios)
- Health check verification

## Project Structure
- `main.py` - FastAPI application implementation
- `requirements.txt` - Python dependencies
- `Dockerfile` - Docker containerization
- `testcases.sh` - Comprehensive test suite
- `README.md` - This documentation