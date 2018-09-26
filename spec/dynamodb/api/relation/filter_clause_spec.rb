# frozen_string_literal: true

RSpec.describe Dynamodb::Api::Relation::FilterClause do
  describe '#initialize' do
    it 'returns filter expression and values' do
      filter_clause = Dynamodb::Api::Relation::FilterClause.
        new('model = :model', ':model': 'S2000')
      expect(filter_clause.expression).to eq('model = :model')
      expect(filter_clause.values).to eq(':model': 'S2000')
    end
  end
end
