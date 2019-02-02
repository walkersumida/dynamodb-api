RSpec.describe Dynamodb::Api::Scan do
  before do
    items = [
      {
        id: '1', maker_id: 1, maker: 'Honda', model: 'Accord', release_date: 19760508, status: 0,
      },
      {
        id: '2', maker_id: 2, maker: 'Toyota', model: 'CROWN', release_date: 19550101, status: 0,
      },
      {
        id: '3', maker_id: 3, maker: 'Tesla', model: 'Model S', release_date: 20120601, status: 0,
      },
      {
        id: '4', maker_id: 1, maker: 'Honda', model: 'S2000', release_date: 19980101, status: 1,
      },
    ]
    DynamodbHelper.new.create_dummy_data(items)
  end

  describe '#all' do
    context 'select clause' do
      it 'works' do
        scan = Dynamodb::Api.scan
        scan.from('cars').
          select('ALL_ATTRIBUTES')
        items = scan.all.items
        expect(items.count).to eq(4)
      end
    end

    context 'limit clause' do
      it 'works' do
        scan = Dynamodb::Api.scan
        scan.from('cars').
          limit(1)
        items = scan.all.items
        expect(items.count).to eq(1)
      end
    end

    context 'filter clause' do
      it 'works' do
        scan = Dynamodb::Api.scan
        scan.from('cars').
          filter('model = :model', ':model': 'S2000')
        items = scan.all.items
        expect(items.count).to eq(1)
      end
    end

    context 'index clause' do
      it 'works(order: maker_id asc, release_date asc)' do
        scan = Dynamodb::Api.scan
        scan.from('cars').
          index('index_maker_id_release_date')
        items = scan.all.items
        expect(items.map { |i| i['id'] }).to eq(%w(1 4 2 3))
      end
    end

    context 'expression attribute names' do
      it 'works' do
        scan = Dynamodb::Api.scan
        scan.from('cars').
          filter('#status = :status', ':status': 1)
        items = scan.all.items
        expect(items.count).to eq(1)
      end
    end
  end
end
