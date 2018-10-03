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
      { maker_id: 1, maker: 'Honda', model: 'NSX', release_date: 19900914 }
    end
    let(:result) do
      query = Dynamodb::Api::Query.new
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
