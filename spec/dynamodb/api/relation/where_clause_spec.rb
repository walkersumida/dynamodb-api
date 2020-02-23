# frozen_string_literal: true

RSpec.describe Dynamodb::Api::Relation::WhereClause do
  describe '#initialize' do
    context 'single condition' do
      context 'value type is array' do
        let(:key_condition) do
          ['maker', '=', %w(Honda)]
        end

        it 'returns conditions for dynamodb' do
          expect(
            Dynamodb::Api::Relation::WhereClause.
              new(key_condition).key_condition
          ).to eq('maker = :maker')
          expect(
            Dynamodb::Api::Relation::WhereClause.
              new(key_condition).attribute_values
          ).to eq({ ':maker' => 'Honda' })
        end
      end

      context 'value type is string' do
        let(:key_condition) do
          [%w(maker = Honda)]
        end

        it 'returns conditions for dynamodb' do
          expect(
            Dynamodb::Api::Relation::WhereClause.
              new(key_condition).key_condition
          ).to eq('maker = :maker')
          expect(
            Dynamodb::Api::Relation::WhereClause.
              new(key_condition).attribute_values
          ).to eq({ ':maker' => 'Honda' })
        end
      end
    end

    context 'multiple conditions' do
      context 'value type is array' do
        let(:key_condition) do
          [%w(maker = Honda), ['release_date', '>=', 19_980_101]]
        end

        it 'returns conditions for dynamodb' do
          expect(
            Dynamodb::Api::Relation::WhereClause.
              new(key_condition).key_condition
          ).to eq('maker = :maker AND release_date >= :release_date')
          expect(
            Dynamodb::Api::Relation::WhereClause.
              new(key_condition).attribute_values
          ).to eq({
            ':maker' => 'Honda',
            ':release_date' => 19_980_101
          })
        end
      end
    end
  end
end
