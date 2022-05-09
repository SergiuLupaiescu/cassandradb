# frozen_string_literal: true

require 'byebug'
require 'sinatra'
require_relative 'services/cassandra_get'
require_relative 'services/cassandra_post'

get '/api/v1/assets/' do
  Services::CassandraGet.new.call
end

post '/api/v1/assets/' do
  data = JSON.parse(request.body.read)
  Services::CassandraPost.new.call(data)
end