# frozen_string_literal: true

require 'dynamodb/api/relation'

module Dynamodb
  module Api
    class Query # :nodoc:
      attr_accessor :relation

      def initialize
        self.relation = Relation.new
      end
    end
  end
end
