require 'serverspec'
require 'docker'

set :backend, :exec

# For docker-api
Docker.url = "http://0.0.0.0:4444"
