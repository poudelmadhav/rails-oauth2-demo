# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:12000", "http://localhost:9000" # your SPA origin

    resource "*",
      headers: :any,
      methods: [ :get, :post, :options ],
      credentials: false
  end
end
