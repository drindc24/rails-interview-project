Rack::Attack.throttle('requests by tenant api key', limit: 100, period: 1.day) do |request|
  request.params[:tenant_key]
end