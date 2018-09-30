# frozen_string_literal: true

RSpec.describe Dynamodb::Api::Relation::ExpressionAttributeNames do
  describe '#initialize' do
    context 'arg is hash' do
      it 'returns expression attribute names' do
        names = { '#status': 'status' }

        expect(
          Dynamodb::Api::Relation::ExpressionAttributeNames.new(names).names
        ).to eq({ '#status': 'status' })
      end
    end

    context 'arg is string' do
      it 'returns expression attribute names' do
        names = '#status'

        expect(
          Dynamodb::Api::Relation::ExpressionAttributeNames.new(names).names
        ).to eq({ '#status': 'status' })
      end
    end

    context 'arg is array' do
      it 'returns expression attribute names' do
        names = ['#status', '#year']

        expect(
          Dynamodb::Api::Relation::ExpressionAttributeNames.new(names).names
        ).to eq({ '#status': 'status', '#year': 'year' })
      end
    end
  end

  describe '#add' do
    context 'arg is string' do
      it 'returns expression attribute names' do
        attr_names = { '#status': 'status' }
        add_name = '#year'
        expression_attribute_names = Dynamodb::Api::Relation::ExpressionAttributeNames.
          new(attr_names)
        expression_attribute_names.add(add_name)

        expect(
          expression_attribute_names.names
        ).to eq({ '#status': 'status', '#year': 'year' })
      end
    end

    context 'arg is hash' do
      it 'returns expression attribute names' do
        attr_names = { '#status': 'status' }
        add_name = { '#year': 'year' }
        expression_attribute_names = Dynamodb::Api::Relation::ExpressionAttributeNames.
          new(attr_names)
        expression_attribute_names.add(add_name)

        expect(
          expression_attribute_names.names
        ).to eq({ '#status': 'status', '#year': 'year' })
      end
    end
  end
end
