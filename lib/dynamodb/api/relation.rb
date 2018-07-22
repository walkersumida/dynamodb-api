# frozen_string_literal: true

require 'dynamodb/api/relation/query_methods'

module Dynamodb
  module Api
    class Relation # :nodoc:
      include QueryMethods
      attr_accessor :from_clause
    end
  end
end
