# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class LimitClause # :nodoc:
        attr_reader :number

        def initialize(number)
          @number = number
        end
      end
    end
  end
end
