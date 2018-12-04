# frozen_string_literal: true

RSpec.describe Dynamodb::Api::Update::Attributes do
  describe '#remove_attributes' do
    subject { Dynamodb::Api::Update::Attributes.new.remove_attributes(key, attributes, table_name) }

    before do
      DynamodbHelper.new.create_dummy_data(items)
    end

    let(:items) do
      [
        {
          id: '1', maker_id: 1, maker: 'Honda', model: 'Accord', release_date: 19760508, status: 1,
        },
        {
          id: '4', maker_id: 1, maker: 'Honda', model: 'S2000', release_date: 19980101, status: 1,
        },
      ]
    end
    let(:table_name) { 'cars' }
    let(:key) do
      { id: '1' }
    end
    let(:attributes) do
      ['status']
    end
    let(:results) do
      query = Dynamodb::Api.query
      query.from('cars').index('index_maker_id_release_date')
      query.where(['maker_id', 'EQ', 1]).filter('#status = :status', ':status': 1)
      query.all.items
    end

    it 'works' do
      is_expected
      expect(results.count).to eq(1)
    end
  end
end
