# frozen_string_literal: true

require 'dynamodb/api/config/options'

module Dynamodb
  module Api
    module Config
      extend self
      extend Options

      option :access_key_id, default: nil
      option :secret_access_key, default: nil
      option :region, default: nil
      option :endpoint, default: nil
      option :retry_limit, default: 10
      option :table_name_prefix, default: ''
      option :index_name_prefix, default: ''

      # @param value [String] the table name
      # @return [String] the table name
      def build_table_name(value)
        return value unless table_name_prefix?
        "#{table_name_prefix}#{value}"
      end
    end
  end
end
