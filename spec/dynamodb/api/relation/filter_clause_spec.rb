# frozen_string_literal: true

RSpec.describe Dynamodb::Api::Relation::FilterClause do
  describe '#initialize' do
    context 'when has not reserved words' do
      it 'returns filter expression and values' do
        filter_clause = Dynamodb::Api::Relation::FilterClause.
          new('model = :model', ':model': 'S2000')

        expect(filter_clause.expression).to eq('model = :model')
        expect(filter_clause.values).to eq(':model': 'S2000')
        expect(filter_clause.reserved_words).to eq([])
      end
    end

    context 'when has reserved words' do
      it 'returns filter expression and values' do
        filter_clause = Dynamodb::Api::Relation::FilterClause.
          new('model = :model and #status = :status and #year = :year',
              ':model': 'S2000', '#status': 1, '#year': 2018)

        expect(filter_clause.expression).
          to eq('model = :model and #status = :status and #year = :year')
        expect(filter_clause.values).
          to eq(':model': 'S2000', '#status': 1, '#year': 2018)
        expect(filter_clause.reserved_words).to eq(['#status', '#year'])
      end
    end
  end
end
