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

      context 'with begins_with operator' do
        let(:key_condition) do
          [%w(maker begins_with Hon)]
        end

        it 'returns conditions for dynamodb' do
          expect(
            Dynamodb::Api::Relation::WhereClause.
            new(key_condition).key_condition
          ).to eq('begins_with(maker, :maker)')
          expect(
            Dynamodb::Api::Relation::WhereClause.
            new(key_condition).attribute_values
          ).to eq({ ':maker' => 'Hon' })
        end
      end

      context 'with between operator' do
        let(:key_condition) do
          [['release_date', 'between', [19_980_101, 20_120_601]]]
        end

        it 'returns conditions for dynamodb' do
          expect(
            Dynamodb::Api::Relation::WhereClause.
            new(key_condition).key_condition
          ).to eq('release_date between :from_release_date AND :to_release_date')
          expect(
            Dynamodb::Api::Relation::WhereClause.
            new(key_condition).attribute_values
          ).to eq({
            ':from_release_date' => 19_980_101,
            ':to_release_date' => 20_120_601
          })
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
