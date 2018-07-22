require 'aws-sdk'
require 'active_support'

require 'dynamodb/api/version'
require 'dynamodb/api/config'
require 'dynamodb/api/adapter'

module Dynamodb
  module Api
    extend self

    def config
      block_given? ? yield(Dynamodb::Api::Config) : Dynamodb::Api::Config
    end

    def adapter
      @adapter ||= Dynamodb::Api::Adapter.new
    end
  end
end
