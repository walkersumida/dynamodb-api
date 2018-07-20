module Dynamodb
  module Api
    class Adapter
      def connect!
        @client = Aws::DynamoDB::Client.new(connect_config)
      end

      def connect_config
        @connect_hash = {}

        if Dynamodb::Api::Config.endpoint?
          @connect_hash[:endpoint] = Dynamodb::Api::Config.endpoint
        end
        if Dynamodb::Api::Config.access_key?
          @connect_hash[:access_key_id] = Dynamodb::Api::Config.access_key
        end
        if Dynamodb::Api::Config.secret_key?
          @connect_hash[:secret_access_key] = Dynamodb::Api::Config.secret_key
        end
        if Dynamodb::Api::Config.region?
          @connect_hash[:region] = Dynamodb::Api::Config.region
        end

        @connect_hash
      end

      def client
        @client
      end
    end
  end
end
