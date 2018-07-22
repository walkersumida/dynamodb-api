# frozen_string_literal: true

module Dynamodb
  module Api
    class Relation
      class GlobalSecondaryIndex
        attr_reader  :name

        def initialize(name)
          @name = name
        end
      end
    end
  end
end
