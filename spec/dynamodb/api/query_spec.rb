RSpec.describe Dynamodb::Api::Query do
  describe '#all' do
    before do
      items = [
        { maker_id: 1, maker: 'Honda', model: 'Accord', release_date: 19760508, status: 0 },
        { maker_id: 2, maker: 'Toyota', model: 'CROWN', release_date: 19550101, status: 0 },
        { maker_id: 3, maker: 'Tesla', model: 'Model S', release_date: 20120601, status: 0 },
        { maker_id: 1, maker: 'Honda', model: 'S2000', release_date: 19980101, status: 1 },
      ]
      DynamodbHelper.new.create_dummy_data(items)
    end

    context 'where clause' do
      it 'works(only hash key)' do
        query = Dynamodb::Api::Query.new
        query.from('cars').index('index_maker_id_release_date').
          where(['maker_id', '=', 1])
        items = query.all.items
        expect(items.count).to eq(2)
      end

      it 'works(hash/range key)' do
        query = Dynamodb::Api::Query.new
        query.from('cars').index('index_maker_id_release_date').
          where([['maker_id', '=', 1], ['release_date', '>=', 19980101]])
        items = query.all.items
        expect(items.count).to eq(1)
      end
    end

    context 'limit clause' do
      it 'works' do
        query = Dynamodb::Api::Query.new
        query.from('cars').index('index_maker_id_release_date').
          where(['maker_id', '=', 1]).
          limit(1)
        items = query.all.items
        expect(items.count).to eq(1)
      end
    end

    context 'filter clause' do
      it 'works' do
        query = Dynamodb::Api::Query.new
        query.from('cars').index('index_maker_id_release_date').
          where(['maker_id', '=', 1]).
          filter('model = :model', ':model': 'S2000')
        items = query.all.items
        expect(items.count).to eq(1)
      end
    end

    context 'expression attribute names' do
      it 'works' do
        query = Dynamodb::Api::Query.new
        query.from('cars').index('index_maker_id_release_date').
          where(['maker_id', '=', 1]).
          filter('#status = :status', ':status': 1)
        items = query.all.items
        expect(items.count).to eq(1)
      end
    end
  end
end
