# frozen_string_literal: true

RSpec.describe Dynamodb::Api::Put::Item do
  describe '#put_item' do
    subject { Dynamodb::Api::Put::Item.put_item(item, table_name) }

    before do
      DynamodbHelper.new.create_dummy_data
    end

    let(:table_name) { 'cars' }
    let(:item) do
      { maker_id: 1, maker: 'Honda', model: 'NSX', release_date: 19900914 }
    end
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
end
