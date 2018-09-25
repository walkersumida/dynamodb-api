# frozen_string_literal: true

module Dynamodb
  module Api
    class ReservedWords # :nodoc:
      attr_accessor :used

      def initialize
        @used = []
      end

      def all
        YAML.safe_load(
          File.open(File.expand_path(__dir__ + '/fixtures/reserved_words.yml'))
        )
      end

      def extract_used(expression)
        binding.pry
        @used = ['status', 'from']
      end
    end
  end
end
