# frozen_string_literal: true

module Dynamodb
  module Api
    class Query # :nodoc:
      attr_reader :relation

      def initialize
        @relation = Relation.new
      end
    end
  end
end
