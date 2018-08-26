# frozen_string_literal: true

RSpec.describe Dynamodb::Api::Relation::LimitClause do
  describe '#initialize' do
    it 'returns limit number' do
      expect(
        Dynamodb::Api::Relation::LimitClause.new(1).number
      ).to eq(1)
    end
  end
end
