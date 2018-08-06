# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class ExpressionAttributeNames
        attr_reader  :names

        def initialize(names)
          @names = names
        end
      end
    end
  end
end

