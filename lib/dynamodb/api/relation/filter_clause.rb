# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class FilterClause # :nodoc:
        attr_reader :expression
        attr_reader :values

        def initialize(expression, values)
          @expression = expression
          @values = values
        end
      end
    end
  end
end
