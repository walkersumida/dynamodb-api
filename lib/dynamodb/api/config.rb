require 'dynamodb/api/config/options'

module Dynamodb
  module Api
    module Config
      extend self
      extend Options

      option :access_key, default: nil
      option :secret_key, default: nil
      option :region, default: nil
      option :endpoint, default: nil
      option :table_name_prefix, default: ''
      option :index_name_prefix, default: ''
    end
  end
end
