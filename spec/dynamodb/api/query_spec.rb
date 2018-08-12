RSpec.describe Dynamodb::Api::Query do
  describe '#initialize' do
    it 'has a aws dynamodb client' do
      expect(Dynamodb::Api::Query.new.client.class).to be Aws::DynamoDB::Client
    end
  end
end

