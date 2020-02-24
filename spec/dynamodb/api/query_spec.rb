RSpec.describe Dynamodb::Api::Query do
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
    context 'where clause' do
      it 'works(only hash key)' do
        query = Dynamodb::Api.query
        query.from('cars').index('index_maker_id_release_date').
          where(['maker_id', '=', 1])
        items = query.all.items
        expect(items.count).to eq(2)
      end

      it 'works(hash/range key)' do
        query = Dynamodb::Api.query
        query.from('cars').index('index_maker_id_release_date').
          where([['maker_id', '=', 1], ['release_date', '>=', 19980101]])
        items = query.all.items
        expect(items.count).to eq(1)
      end

      it 'works(using BEGINS_WITH)' do
        query = Dynamodb::Api.query
        query.from('cars').index('index_maker_id_model').
          where([['maker_id', '=', 1], ['model', 'begins_with', 'S2']])
        items = query.all.items
        expect(items.count).to eq(1)
      end

      it 'works(using BETWEEN)' do
        query = Dynamodb::Api.query
        query.from('cars').index('index_maker_id_release_date').
          where(
            [
              ['maker_id', '=', 1],
              ['release_date', 'between', [19550101, 19980101]],
            ]
          )
        items = query.all.items
        expect(items.count).to eq(2)
      end
    end

    context 'limit clause' do
      it 'works' do
        query = Dynamodb::Api.query
        query.from('cars').index('index_maker_id_release_date').
          where(['maker_id', '=', 1]).
          limit(1)
        items = query.all.items
        expect(items.count).to eq(1)
      end
    end

    context 'filter clause' do
      it 'works' do
        query = Dynamodb::Api.query
        query.from('cars').index('index_maker_id_release_date').
          where(['maker_id', '=', 1]).
          filter('model = :model', ':model': 'S2000')
        items = query.all.items
        expect(items.count).to eq(1)
      end
    end

    context 'expression attribute names' do
      it 'works' do
        query = Dynamodb::Api.query
        query.from('cars').index('index_maker_id_release_date').
          where(['maker_id', '=', 1]).
          filter('#status = :status', ':status': 1)
        items = query.all.items
        expect(items.count).to eq(1)
      end
    end
  end

  describe '#next' do
    context 'exists last_evaluated_key' do
      it 'returns next items' do
        query = Dynamodb::Api.query
        query.from('cars').index('index_maker_id_release_date').
          where(['maker_id', '=', 1]).
          limit(1)
        result = query.all
        expect(result.items.map { |i| i['id'] }).to eq(%w(4))
        result = query.next
        expect(result.items.map { |i| i['id'] }).to eq(%w(1))
      end
    end

    context 'not exists last_evaluated_key' do
      it 'returns nil' do
        query = Dynamodb::Api.query
        query.from('cars').index('index_maker_id_release_date').
          where(['maker_id', '=', 1]).
          limit(2)
        _result = query.all
        result = query.next
        expect(result).to be nil
      end
    end
  end
end
