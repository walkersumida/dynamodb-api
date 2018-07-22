# frozen_string_literal: true

module Dynamodb
  module Api
    class Query # :nodoc:
      attr_reader :client
      attr_reader :relation

      def initialize
        @relation = Relation.new
        @client = Adapter.new.client
      end
    end
  end
end
