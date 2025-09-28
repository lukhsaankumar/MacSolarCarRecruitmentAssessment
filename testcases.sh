#!/bin/bash
# Solar Car API Test Suite
# 
# Make sure the API server is running on localhost:8000 before running this script
# Usage: chmod +x testcases.sh && ./testcases.sh

echo "Solar Car API Test Suite"
echo "========================"

BASE_URL="http://localhost:8000"
echo "Testing API at: $BASE_URL"
echo ""

# Check if jq is available for pretty JSON formatting
if command -v jq &> /dev/null; then
    USE_JQ=true
    echo "Using jq for pretty JSON formatting"
else
    USE_JQ=false
    echo "jq not found - install with 'sudo apt install jq' for pretty formatting"
fi
echo ""

# Function to run test with optional jq formatting
run_test() {
    local test_name="$1"
    local curl_cmd="$2"
    local is_error_test="${3:-false}"
    
    echo "$test_name"
    echo "Command: $curl_cmd"
    
    if [ "$USE_JQ" = true ] && [ "$is_error_test" = false ]; then
        eval "$curl_cmd | jq"
    else
        eval "$curl_cmd"
    fi
    echo ""
    echo "----------------------------------------"
    echo ""
}

# Health check first
echo "HEALTH CHECK"
echo "==============="
run_test "Health Check" "curl -X GET $BASE_URL/"

echo "VALID TEST CASES"
echo "=================="

run_test "1. Valid Request (Happy Path)" \
    "curl -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [45, 23, 78, 12, 91, 34, 67, 89, 56, 3]}'"

run_test "2. Single Number" \
    "curl -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [42]}'"

run_test "3. Empty List" \
    "curl -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": []}'"

run_test "4. Already Sorted Numbers" \
    "curl -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [1, 2, 3, 4, 5]}'"

run_test "5. Reverse Sorted Numbers" \
    "curl -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [5, 4, 3, 2, 1]}'"

run_test "6. Negative Numbers" \
    "curl -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [-10, -5, 0, 5, 10]}'"

run_test "7. Mixed Negative and Positive" \
    "curl -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [3, -1, 4, -2, 0]}'"

run_test "8. Duplicate Numbers" \
    "curl -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [3, 1, 4, 1, 5, 9, 2, 6, 5, 3]}'"

run_test "9. Large Numbers" \
    "curl -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [1000000, 999999, 1000001]}'"

run_test "10. All Same Numbers" \
    "curl -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [7, 7, 7, 7, 7]}'"

echo "ERROR TEST CASES (Should Return 422)"
echo "======================================"

run_test "11. Missing 'numbers' Field" \
    "curl -i -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{}'" \
    true

run_test "12. Wrong Field Name" \
    "curl -i -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"nums\": [1, 2, 3]}'" \
    true

run_test "13. Numbers Field is Not a List (String)" \
    "curl -i -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": \"not a list\"}'" \
    true

run_test "14. Numbers Field is Not a List (Integer)" \
    "curl -i -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": 123}'" \
    true

run_test "15. Numbers Field is Null" \
    "curl -i -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": null}'" \
    true

run_test "16. List Contains Non-Integers (Strings)" \
    "curl -i -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [1, \"two\", 3]}'" \
    true

run_test "17. List Contains Non-Integers (Floats)" \
    "curl -i -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [1, 2.5, 3]}'" \
    true

run_test "18. List Contains Non-Integers (Booleans)" \
    "curl -i -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [1, true, 3]}'" \
    true

run_test "19. List Contains Mixed Invalid Types" \
    "curl -i -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [1, \"two\", 3.5, true, null]}'" \
    true

run_test "20. Invalid JSON Syntax" \
    "curl -i -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json' -d '{\"numbers\": [1, 2, 3'" \
    true

run_test "21. No Content-Type Header" \
    "curl -i -X POST $BASE_URL/sorted-numbers -d '{\"numbers\": [1, 2, 3]}'" \
    true

run_test "22. Empty Request Body" \
    "curl -i -X POST $BASE_URL/sorted-numbers -H 'Content-Type: application/json'" \
    true

echo "TEST SUITE COMPLETE!"
echo "====================="
echo "Summary:"
echo "- Valid cases should return 200 with properly formatted JSON"
echo "- Error cases should return 422 with detailed error messages"
echo "- Health check should return 200 with success message"
echo ""
echo "Look for:"
echo "- HTTP status codes (200 for success, 422 for validation errors)"
echo "- Proper JSON structure in successful responses"
echo "- Detailed error messages in failed responses"
echo ""
echo "If any tests fail, check that the API server is running at $BASE_URL"