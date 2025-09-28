# McMaster Solar Car Operations Team - Development Challenge

Welcome to the McMaster Solar Car Operations Team's online assessment!

We are looking for a full-stack developer(s) who can help us improve our reimbursement platform. The full application can be viewed here: https://github.com/McMaster-Solar-Car-Project/purchase-request-site

This assessment is designed to evaluate your full-stack development skills and will be similar to the day to day tasks. 

**AI assistance, documentation, Stack Overflow ARE allowed. Take full advantage of it!**

We care about practical problem-solving, documentation style, well structured code, and a working product. Not algorithmic complexity. Figure out what the best solution is and go with it. There are multiple ways to solve this problem.

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

Please submit a zip file containing the following files:
- `main.py` - Your API implementation
- `requirements.txt` - Python dependencies (or if you are using a different package manager like uv, include the equivalent)
- `Dockerfile` - Docker configuration
- `README.md` - Documentation (optional but appreciated)

Successful candidates will be contacted for an interview.