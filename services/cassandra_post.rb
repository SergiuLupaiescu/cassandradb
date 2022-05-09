# frozen_string_literal: true

require 'byebug'
require 'cassandra'
require 'json'
require 'rainbow'

module Services
  class CassandraPost

    def initialize
    end

    def call(data)
      assets(data)
    end

    private

    def assets(data)
      cluster = Cassandra.cluster(hosts: %w[172.17.0.2])
      keyspace = 'stp_cluster'
      session  = cluster.connect(keyspace)
      # statement = session.prepare("INSERT INTO assets (id, metadata, data) VALUES (#{data['id']}, \'#{data['metadata']}\', \'#{data['data']}\')")
      statement = "INSERT INTO assets (id, metadata, data) VALUES (#{data['id']}, \'#{data['metadata']}\', \'#{data['data']}\')"
      session.execute_async(statement)
      response = {
                   'success': 'Data inserted successfully!',
                   'asset': {
                     'id': data['id'],
                     'metadata': data['metadata'],
                     'data': data['data']
                   }
      }.to_json
      response
    end
  end
end
