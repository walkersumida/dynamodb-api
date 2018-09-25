RSpec.describe Dynamodb::Api::ReservedWords do
  describe '#all' do
    it 'works' do
      expect(Dynamodb::Api::ReservedWords.new.all.count).to eq(573)
    end
  end

  describe '#extract_used' do
    subject { reserved_words.extract_used(expression) }

    let(:reserved_words) { Dynamodb::Api::ReservedWords.new }

    context 'pattern 1' do
      let(:expression) { 'status = :status and from = :from and :to = to' }

      it 'works' do
        is_expected.to eq(['status', 'from', 'to'])
        expect(reserved_words.used).to eq(['status', 'from', 'to'])
      end
    end

    xcontext 'pattern 2' do
      let(:expression) { '(status = :status and from = :from and :to = to)' }

      it 'works' do
        is_expected.to eq(['status', 'from', 'to'])
        expect(reserved_words.used).to eq(['status', 'from', 'to'])
      end
    end
  end
end
