# frozen_string_literal: true

RSpec.describe Dynamodb::Api::Put::Item do
  before do
    DynamodbHelper.new.create_dummy_data
  end

  let(:table_name) { 'cars' }
  let(:item) do
    { id: '5', maker_id: 1, maker: 'Honda', model: 'NSX', release_date: 19900914 }
  end

  describe '#put_item' do
    subject { Dynamodb::Api::Put::Item.put_item(item, table_name) }

    let(:result) do
      query = Dynamodb::Api.query
      query.from('cars').index('index_maker_id_release_date')
      query.where(['maker_id', 'EQ', 1])
      query.all.items.detect { |i| i['model'] == 'NSX' }
    end

    it 'works' do
      is_expected
      expect(result['model']).to eq('NSX')
    end
  end

  describe '#put_item table name prefix test' do
    subject { Dynamodb::Api::Put::Item.put_item(item, table_name) }

    let(:prefix) { 'prefix_' }

    before do
      Dynamodb::Api.config.table_name_prefix = prefix
    end

    it '(prefix) is added to table name' do
      mock = double('Adapter.client')
      allow(mock).to receive(:put_item)
      allow(Dynamodb::Api::Adapter).to receive(:client).and_return(mock)
      expect(mock).to receive(:put_item).with(item: item, table_name: "#{prefix}#{table_name}")

      is_expected
    end
  end
end
