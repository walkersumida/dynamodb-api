# frozen_string_literal: true

RSpec.describe Dynamodb::Api::Update::Item do
  before do
    DynamodbHelper.new.create_dummy_data(items)
  end

  let(:items) do
    [
      {
        id: '1', maker_id: 1, maker: 'Honda', model: 'Accord', release_date: 19760508, status: 0,
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
  let(:item) do
    { status: 1, new_col: 'new' }
  end

  describe '#update_item' do
    subject { Dynamodb::Api::Update::Item.new.update_item(key, item, table_name) }

    let(:results) do
      query = Dynamodb::Api.query
      query.from('cars').index('index_maker_id_release_date')
      query.where(['maker_id', 'EQ', 1]).filter('#status = :status', ':status': 1)
      query.all.items
    end

    it 'works' do
      is_expected
      expect(results.detect { |i| i['model'] == 'Accord' }['model']).to eq(items[0][:model])
      expect(results.detect { |i| i['model'] == 'Accord' }['new_col']).to eq('new')
      expect(results.count).to eq(2)
    end
  end

  describe '#update_item table name prefix test' do
    subject { Dynamodb::Api::Update::Item.new.update_item(key, item, table_name) }

    let(:prefix) { 'prefix_' }

    before do
      Dynamodb::Api.config.table_name_prefix = prefix
    end

    it '(prefix) is added to table name' do
      mock = double('Adapter.client')
      allow(mock).to receive(:update_item)
      allow(Dynamodb::Api::Adapter).to receive(:client).and_return(mock)
      expect(mock).to receive(:update_item).
        with(hash_including(table_name: "#{prefix}#{table_name}"))

      is_expected
    end
  end
end
