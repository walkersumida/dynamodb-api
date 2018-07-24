# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class OrderClause # :nodoc:
        attr_reader :direct

        def initialize(direct = nil)
          @direct = key_map(direct)
        end

        private

        def key_map(direct)
          case direct
          when nil
            false
          when 'desc'
            false
          when 'asc'
            true
          else
            false
          end
        end
      end
    end
  end
end
