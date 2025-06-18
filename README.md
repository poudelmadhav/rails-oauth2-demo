# OAuth 2 Demo - Rails Auth Server + SPA Clients

This project demonstrates an OAuth2 setup using a **Ruby on Rails authorization server** (with Doorkeeper + Devise) and two separate **JavaScript single-page clients** (Client1 and Client2). The server also supports **OpenID Connect** for identity authentication flow.

---

## 🧩 Folder Structure

```
.
├── rails-auth-server/     # Rails OAuth2 authorization server
├── client1/               # Single Page App 1
└── client2/               # Single Page App 2
```

---

## 🚀 Setup Instructions

### ✅ 1. Setup the Rails OAuth Server

```bash
cd rails-auth-server
bundle install
rails db:setup
```

### Generate RSA private key for OpenID Connect

The OpenID Connect implementation requires an RSA private key for signing JWT tokens. Before starting the server, check if you need to generate this key:

**Note: Make sure you are in the `rails-auth-server` directory for these steps.**

1. Look for the file `config/keys/private.pem`
2. If this file does not exist, generate it with:

```bash
openssl genrsa -out config/keys/private.pem 2048
```

3. For security, you may want to restrict file permissions:

```bash
chmod 600 config/keys/private.pem
```

Create a Doorkeeper application:

```bash
rails console
```

```ruby
app = Doorkeeper::Application.create!(
  name: "Awesome Client",
  redirect_uri: "http://localhost:12000 http://localhost:9000",  # Replace with your SPA URL for client1 and client2
  scopes: "openid email profile",
  trusted: true,
  confidential: false
)
puts "Client ID: \#{app.uid}"
puts "Secret: \#{app.secret}" # Not needed for public clients (confidential: false)
```

### Create a User Account

```ruby
# Create a new user
User.create!(
  email: "user@example.com",
  password: "password123",
  password_confirmation: "password123"
)
```

### Start the Rails server

```bash
rails server -p 4000
```

---

### ✅ 2. Setup and Run SPA Clients

Each client is a static HTML + JS app.

#### Client1 (at port 12000)

```bash
cd client1
python3 -m http.server 12000
```

#### Client2 (at port 9000)

```bash
cd client2
python3 -m http.server 9000
```

---

## ✍️ Update SPA with Client ID

In each `index.html` (for client1 & client2), update:

```js
const CLIENT_ID = 'REPLACE_WITH_ACTUAL_CLIENT_ID';
```

You can get this from the `rails console` output.

Also, make sure:

```js
const AUTH_SERVER_URL = 'http://localhost:4000';
```

---

## 📄 Useful Endpoints

* `GET /oauth/authorize` – Begin auth flow
* `POST /oauth/token` – Exchange code / refresh token
* `GET /api/v1/profiles/me` – Protected API endpoint
* `GET /oauth/applications` - View and manage OAuth applications (admin interface)

### OpenID Connect Endpoints
* `GET /.well-known/openid-configuration` - OpenID Connect discovery document
* `GET /oauth/userinfo` - User information endpoint
* `GET /oauth/discovery/keys` - JSON Web Key Set for verifying tokens

---

## 🔐 OpenID Connect Support

This project includes support for OpenID Connect on top of OAuth2. OpenID Connect extends OAuth2 by providing identity verification and authentication details alongside authorization.

### OpenID Connect Features
* **ID Tokens**: JWT format tokens containing authenticated user information
* **Standard Claims**: Access to user profile information such as email, name, and profile
* **Discovery Document**: Well-known endpoint for clients to discover server capabilities
* **Userinfo Endpoint**: Additional endpoint to fetch user details

### Using OpenID Connect
To use OpenID Connect in your client applications, request the appropriate scopes:
* `openid` - Required for OpenID Connect flow
* `profile` - Access to user's name and basic profile info
* `email` - Access to user's email address

Example authorization request with OpenID Connect:
```
http://localhost:4000/oauth/authorize?
  client_id=YOUR_CLIENT_ID&
  redirect_uri=http://localhost:12000&
  response_type=code&
  scope=openid profile email
```

---

## 🧪 Testing Token Expiration

* Tokens expires (`2.hours` by default). You can change this in `config/initializers/doorkeeper.rb`.
* After expiry, token is refreshed automatically.
* If refresh token is also expired, user is redirected to authorize again.

---

## ✅ Done!

Now you can test login, token expiry, refreshing, logout, and cross-client sign-in/out!
