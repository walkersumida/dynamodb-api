# frozen_string_literal: true

RSpec.describe Dynamodb::Api::Delete::Item do
  before do
    items = [
      {
        id: '1', maker_id: 1, maker: 'Honda', model: 'Accord', release_date: 19760508, status: 0,
      },
      {
        id: '4', maker_id: 1, maker: 'Honda', model: 'S2000', release_date: 19980101, status: 1,
      },
    ]
    DynamodbHelper.new.create_dummy_data(items)
  end

  let(:table_name) { 'cars' }
  let(:item) do
    { id: '4' }
  end

  describe '#delete_item' do
    subject { Dynamodb::Api::Delete::Item.delete_item(item, table_name) }

    let(:results) do
      query = Dynamodb::Api.query
      query.from('cars').index('index_maker_id_release_date')
      query.where(['maker_id', 'EQ', 1])
      query.all.items
    end

    it 'works' do
      is_expected
      expect(results.detect { |i| i['model'] == 'S2000' }).to eq(nil)
      expect(results.count).to eq(1)
    end
  end
end
