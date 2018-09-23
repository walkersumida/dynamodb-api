RSpec.describe Dynamodb::Api::ReservedWords do
  describe '#all' do
    it 'works' do
      expect(Dynamodb::Api::ReservedWords.new.all.count).to eq(573)
    end
  end
end
