# frozen_string_literal: true

module Dynamodb
  module Api
    module Map
      class Operator # :nodoc:
        def self.key(k)
          k = k.gsub(' ', '')
          case k
          when '='
            'EQ'
          when '!='
            'NE'
          when '<='
            'LE'
          when '<'
            'LT'
          when '>='
            'GE'
          when '>'
            'GT'
          else
            k
          end
        end
      end
    end
  end
end
