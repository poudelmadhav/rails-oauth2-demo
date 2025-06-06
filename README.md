# OAuth 2 Demo - Rails Auth Server + SPA Clients

This project demonstrates an OAuth2 setup using a **Ruby on Rails authorization server** (with Doorkeeper + Devise) and two separate **JavaScript single-page clients** (Client1 and Client2).

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

Create a Doorkeeper application:

```bash
rails console
```

```ruby
app = Doorkeeper::Application.create!(
  name: "Awesome Client",
  redirect_uri: "http://localhost:12000 http://localhost:9000",  # Replace with your SPA URL for client1 and client2
  scopes: "public"
)
puts "Client ID: \#{app.uid}"
puts "Secret: \#{app.secret}" # Not needed for public clients (confidential: false)
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

---

## 🧪 Testing Token Expiration

* Tokens expires (`2.hours` by default). You can change this in `config/initializers/doorkeeper.rb`.
* After expiry, token is refreshed automatically.
* If refresh token is also expired, user is redirected to authorize again.

---

## ✅ Done!

Now you can test login, token expiry, refreshing, logout, and cross-client sign-in/out!
