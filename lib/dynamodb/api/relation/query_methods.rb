# frozen_string_literal: true

require 'dynamodb/api/relation/from_clause'

module Dynamodb
  module Api
    module QueryMethods # :nodoc:
      def from(value)
        self.from_clause = Relation::FromClause.new(value)
        self
      end

      def index(value)
        self.index_clause = Relation::GlobalSecondaryIndex.new(value)
        self
      end

      def select(value = nil)
        self.select_clause = Relation::SelectClause.new(value)
        self
      end
    end
  end
end
