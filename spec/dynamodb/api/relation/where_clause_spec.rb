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
            Dynamodb::Api::Relation::WhereClause.new(key_condition).key_conditions
          ).to eq(
            'maker' => {
              attribute_value_list: %w(Honda),
              comparison_operator: 'EQ',
            }
          )
        end
      end

      context 'value type is string' do
        let(:key_condition) do
          [%w(maker = Honda)]
        end

        it 'returns conditions for dynamodb' do
          expect(
            Dynamodb::Api::Relation::WhereClause.new(key_condition).
              key_conditions
          ).to eq(
            'maker' => {
              attribute_value_list: %w(Honda),
              comparison_operator: 'EQ',
            }
          )
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
            Dynamodb::Api::Relation::WhereClause.new(key_condition).key_conditions
          ).to eq(
            'maker' => {
              attribute_value_list: %w(Honda),
              comparison_operator: 'EQ',
            },
            'release_date' => {
              attribute_value_list: [19_980_101],
              comparison_operator: 'GE',
            }
          )
        end
      end
    end
  end
end
