# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class SelectClause # :nodoc:
        attr_reader :name

        def initialize(name = nil)
          @name = name || 'ALL_ATTRIBUTES'
        end
      end
    end
  end
end
