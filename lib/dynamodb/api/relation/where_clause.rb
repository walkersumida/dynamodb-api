# frozen_string_literal: true

module Dynamodb
  module Api
    class Relation
      class WhereClause # :nodoc:
        attr_reader :key
        attr_reader :value
        attr_reader :operator

        def initialize(key, value, operator)
          @key = key
          @value = value
          @operator = operator
        end
      end
    end
  end
end
