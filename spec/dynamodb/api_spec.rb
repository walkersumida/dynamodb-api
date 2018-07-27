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
end
