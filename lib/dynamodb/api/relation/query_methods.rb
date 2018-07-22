# frozen_string_literal: true

require 'dynamodb/api/relation/from_clause'

module Dynamodb
  module Api
    module QueryMethods # :nodoc:
      def from(value)
        self.from_clause = Relation::FromClause.new(value)
        self
      end
    end
  end
end
