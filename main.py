from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field, validator
from typing import List
import uvicorn

# Requirement 1: API application using FastAPI (chosen framework)
app = FastAPI(title="Solar Car API", description="API for sorting numbers")

# Requirement 6 & 7: Input validation and error handling
# Pydantic models automatically validate input and handle errors gracefully
class NumbersRequest(BaseModel):
    # Field(...) ensures 'numbers' is required in request body (Requirement 7)
    # List[int] ensures it's a list of integers (Requirement 7)
    numbers: List[int] = Field(..., description="List of integers to sort")
    
    @validator('numbers', pre=True, each_item=True)
    def validate_no_booleans(cls, v):
        """Reject boolean values since JSON true/false convert to 1/0"""
        if isinstance(v, bool):
            raise ValueError('Boolean values are not allowed')
        return v

# Requirement 4 & 5: Return both original and sorted numbers in JSON format
class NumbersResponse(BaseModel):
    original_numbers: List[int]
    sorted_numbers: List[int]

# Requirement 1: Single endpoint '/sorted-numbers' 
# Requirement 2: Accepts POST requests (clarified - not GET as initially mentioned)
# Requirement 3: Accepts list of integers in request body (handled by NumbersRequest model)
@app.post("/sorted-numbers", response_model=NumbersResponse)
async def sort_numbers(request: NumbersRequest):
    """
    Sort a list of numbers and return both original and sorted versions.
    
    Args:
        request: JSON body containing 'numbers' field with list of integers
        
    Returns:
        JSON response with original_numbers and sorted_numbers
    
    Error Handling (Requirements 6 & 7):
    - FastAPI + Pydantic automatically validates:
      - Missing 'numbers' field → 422 Unprocessable Entity
      - Invalid data types → 422 Unprocessable Entity
      - Non-list or non-integer values → 422 Unprocessable Entity
    """
    # Requirement 4: Return numbers in both original and sorted order
    original = request.numbers
    sorted_nums = sorted(original)
    
    # Requirement 5: Return response in JSON format (handled by FastAPI + response_model)
    return NumbersResponse(
        original_numbers=original,
        sorted_numbers=sorted_nums
    )

@app.get("/")
async def root():
    """Health check endpoint"""
    return {"message": "Solar Car API is running"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)