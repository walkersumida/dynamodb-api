RSpec.describe Dynamodb::Api do
  it 'has a version number' do
    expect(Dynamodb::Api::VERSION).not_to be nil
  end

  describe '#config' do
    context 'when block_given is true' do
      before do
        Dynamodb::Api.config do |config|
          config.endpoint = 'http://1.1.1.1:8000'
        end
      end

      it 'works' do
        expect(Dynamodb::Api::Config.endpoint).to eq('http://1.1.1.1:8000')
      end
    end

    context 'when block_given is false' do
      it 'works' do
        expect(Dynamodb::Api.config).to eq(Dynamodb::Api::Config)
      end
    end
  end

  describe '#adapter' do
    it 'returns a Dynamodb::Api::Adapter class' do
      expect(Dynamodb::Api.adapter.class).to eq(Dynamodb::Api::Adapter)
    end
  end

  describe '#query' do
    it 'returns a Dynamodb::Api::Query class' do
      expect(Dynamodb::Api.query.class).to eq(Dynamodb::Api::Query)
    end
  end

  describe '#insert' do
    subject { Dynamodb::Api.insert(table_name, item) }

    before do
      DynamodbHelper.new.create_dummy_data
    end

    let(:table_name) { 'cars' }
    let(:item) do
      { id: '5', maker_id: 1, maker: 'Honda', model: 'NSX', release_date: 19900914 }
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

  describe '#update' do
    subject { Dynamodb::Api.update(table_name, key, item) }

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

  describe '#delete' do
    subject { Dynamodb::Api.delete(table_name, item) }

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

  describe '#remove_attributes' do
    subject { Dynamodb::Api.remove_attributes(table_name, key, attributes) }

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
