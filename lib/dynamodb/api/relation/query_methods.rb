# frozen_string_literal: true

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

      def order(value = nil)
        self.order_clause = Relation::OrderClause.new(value)
        self
      end

      def where(key_conditions)
        self.where_clause = Relation::WhereClause.new(key_conditions)
        self
      end

      def filter(expression, values)
        self.filter_clause = Relation::FilterClause.new(expression, values)
        self
      end
    end
  end
end
