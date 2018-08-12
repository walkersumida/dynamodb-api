RSpec.describe Dynamodb::Api::Adapter do
  describe '#initialize' do
    it 'has a aws dynamodb client' do
      expect(Dynamodb::Api::Adapter.new.client.class).to be Aws::DynamoDB::Client
    end
  end
end

