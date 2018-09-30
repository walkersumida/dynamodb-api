# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class FilterClause # :nodoc:
        attr_reader :expression
        attr_reader :values
        attr_reader :reserved_words

        def initialize(expression, values)
          @expression = expression
          @values = values
          @reserved_words = extract_reserved_words(@expression)
        end

        private

        def extract_reserved_words(expression)
          expression.scan(/\#\w+/)
        end
      end
    end
  end
end
