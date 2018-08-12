module Dynamodb
  module Api
    class Adapter # :nodoc:
      attr_reader :_client

      def self.client
        @_client ||= Aws::DynamoDB::Client.new(connect_config)
      end

      def self.connect_config
        config_keys = %w[endpoint access_key_id secret_access_key region]
        @connect_hash = {}

        config_keys.each do |config_key|
          if Dynamodb::Api::Config.send("#{config_key}?")
            @connect_hash[config_key.to_sym] =
              Dynamodb::Api::Config.send(config_key)
          end
        end

        @connect_hash
      end
    end
  end
end
