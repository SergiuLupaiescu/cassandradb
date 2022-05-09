# frozen_string_literal: true

require 'byebug'
require 'cassandra'
require 'json'
require 'rainbow'

module Services
  class CassandraGet

    def initialize ;end

    def call
      assets
    end

    private

    def assets
      cluster = Cassandra.cluster(hosts: %w[172.17.0.2])
      keyspace = 'stp_cluster'
      session  = cluster.connect(keyspace)
      statement = session.prepare('SELECT * FROM assets')
      future = session.execute_async(statement)
      data = future.join.rows.to_a
      response = {'data': data}.to_json
      response
    end
  end
end