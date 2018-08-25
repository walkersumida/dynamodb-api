# frozen_string_literal: true

RSpec.describe Dynamodb::Api::Relation::FromClause do
  describe '#initialize' do
    context 'table_name_prefix is empty' do
      before do
        Dynamodb::Api::Config.table_name_prefix = ''
      end

      let(:table_name) { 'table_name' }

      it 'returns a table name' do
        expect(Dynamodb::Api::Relation::FromClause.new(table_name).name)
          .to eq table_name
      end
    end

    context 'table_name_prefix is not empty' do
      before do
        Dynamodb::Api::Config.table_name_prefix = 'prefix_'
      end

      let(:table_name) { 'table_name' }

      it 'returns a table name' do
        expect(Dynamodb::Api::Relation::FromClause.new(table_name).name)
          .to eq('prefix_' + table_name)
      end
    end
  end
end
