# frozen_string_literal: true

module Dynamodb
  module Api
    module Relation
      class ExpressionAttributeNames
        attr_accessor :names

        def initialize(names)
          self.names = {}

          case names.class.to_s
          when 'String'
            add(names)
          when 'Array'
            names.each do |name|
              add(name)
            end
          when 'Hash'
            self.names = names
          else
            raise "#{names.class} is not support"
          end
        end

        def add(names)
          _names = formatting(names)
          self.names.merge!(_names)
        end

        private

        def formatting(names)
          _names = names.is_a?(Array) ? names : [names]
          _names.each_with_object({}) do |name, hash|
            next hash[name.to_sym] = remove_hash_tag(name) if name.is_a?(String)
            next hash.merge!(name) if name.is_a?(Hash)
            raise "#{name.class} is not support"
          end
        end

        def remove_hash_tag(name)
          name.gsub(/\#/, '')
        end
      end
    end
  end
end
