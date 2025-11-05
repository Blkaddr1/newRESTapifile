# Replace YOUR_RENDER_URL with your actual Render URL (e.g., https://your-app.onrender.com)
RENDER_URL="YOUR_RENDER_URL"

# ==========================================
# OAUTH FLOW (if you want to test full flow)
# ==========================================

# Step 1: Get Authorization Code
curl -L "${RENDER_URL}/oauth/authorize?client_id=client123&redirect_uri=http://localhost:3001/callback&response_type=code&state=xyz123"

# Step 2: Exchange Code for Token (using pre-filled dummy code)
curl -X POST ${RENDER_URL}/oauth/token \
  -H "Content-Type: application/json" \
  -d '{
    "grant_type": "authorization_code",
    "code": "sandbox_auth_code_abcdef",
    "client_id": "client123",
    "client_secret": "secret456",
    "redirect_uri": "http://localhost:3001/callback"
  }'

# ==========================================
# DIRECT API TESTING (using dummy token)
# ==========================================

# Health Check
curl ${RENDER_URL}/health

# Get authenticated user info
curl ${RENDER_URL}/api/me \
  -H "Authorization: Bearer sandbox_access_token_12345"

# ==========================================
# USER ENDPOINTS
# ==========================================

# GET - Get all users
curl ${RENDER_URL}/api/users \
  -H "Authorization: Bearer sandbox_access_token_12345"

# GET - Get specific user (Brandon Berrett)
curl ${RENDER_URL}/api/users/1 \
  -H "Authorization: Bearer sandbox_access_token_12345"

# POST - Create new user
curl -X POST ${RENDER_URL}/api/users \
  -H "Authorization: Bearer sandbox_access_token_12345" \
  -H "Content-Type: application/json" \
  -d '{
    "name": {"first": "Test", "last": "User"},
    "email": "testuser@example.com",
    "phone": "5551234567",
    "acct": {"name": "Basic", "num": "111222", "pin": "9999", "status": "Active"},
    "address": {"street": "123 Test St", "apt": null, "city": "Test City", "state": "Test State", "country": "USA", "zipcode": "12345"}
  }'

# PUT - Replace entire user
curl -X PUT ${RENDER_URL}/api/users/1 \
  -H "Authorization: Bearer sandbox_access_token_12345" \
  -H "Content-Type: application/json" \
  -d '{
    "name": {"first": "Brandon", "last": "Updated"},
    "email": "updated@email.com",
    "phone": "8015559999",
    "acct": {"name": "Platinum Select", "num": "456789", "pin": "5813", "status": "Active"},
    "address": {"street": "449S. 860E.", "apt": null, "city": "American Fork", "state": "Utah", "country": "USA", "zipcode": "84003"}
  }'

# PATCH - Partial update (just phone)
curl -X PATCH ${RENDER_URL}/api/users/1 \
  -H "Authorization: Bearer sandbox_access_token_12345" \
  -H "Content-Type: application/json" \
  -d '{"phone": "8015551111"}'

# DELETE - Delete user
curl -X DELETE ${RENDER_URL}/api/users/10 \
  -H "Authorization: Bearer sandbox_access_token_12345"

# HEAD - Check if user exists (no body returned)
curl -I ${RENDER_URL}/api/users/1 \
  -H "Authorization: Bearer sandbox_access_token_12345"

# OPTIONS - Get allowed methods
curl -X OPTIONS ${RENDER_URL}/api/users/1

# ==========================================
# PRODUCT ENDPOINTS
# ==========================================

# GET - Get all products
curl ${RENDER_URL}/api/products \
  -H "Authorization: Bearer sandbox_access_token_12345"

# GET - Get specific product
curl ${RENDER_URL}/api/products/1 \
  -H "Authorization: Bearer sandbox_access_token_12345"

# POST - Create new product
curl -X POST ${RENDER_URL}/api/products \
  -H "Authorization: Bearer sandbox_access_token_12345" \
  -H "Content-Type: application/json" \
  -d '{"name": "Product C", "price": 99.99, "stock": 25}'

# PUT - Replace entire product
curl -X PUT ${RENDER_URL}/api/products/1 \
  -H "Authorization: Bearer sandbox_access_token_12345" \
  -H "Content-Type: application/json" \
  -d '{"name": "Product A Updated", "price": 39.99, "stock": 150}'

# PATCH - Partial update (just stock)
curl -X PATCH ${RENDER_URL}/api/products/1 \
  -H "Authorization: Bearer sandbox_access_token_12345" \
  -H "Content-Type: application/json" \
  -d '{"stock": 200}'

# DELETE - Delete product
curl -X DELETE ${RENDER_URL}/api/products/2 \
  -H "Authorization: Bearer sandbox_access_token_12345"

# HEAD - Check if product exists
curl -I ${RENDER_URL}/api/products/1 \
  -H "Authorization: Bearer sandbox_access_token_12345"

# OPTIONS - Get allowed methods for products
curl -X OPTIONS ${RENDER_URL}/api/products/1

# ==========================================
# REFRESH TOKEN
# ==========================================

curl -X POST ${RENDER_URL}/oauth/token \
  -H "Content-Type: application/json" \
  -d '{
    "grant_type": "refresh_token",
    "refresh_token": "sandbox_refresh_token_67890",
    "client_id": "client123",
    "client_secret": "secret456"
  }'