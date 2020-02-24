class DynamodbHelper
  attr_writer :items

  def create_dummy_data(items = nil)
    self.items = items
    create_table
    create_items
  end

  def delete_dummy_data
    delete_tables
  end

  private

  def delete_tables
    client = Dynamodb::Api::Adapter.client
    table_names = client.list_tables[:table_names]
    table_names.each do |table_name|
      client.delete_table(table_name: table_name)
    end
  end

  def create_table
    client = Dynamodb::Api::Adapter.client
    client.create_table(
      attribute_definitions: attribute_definitions,
      key_schema: key_schema,
      global_secondary_indexes: global_secondary_indexes,
      provisioned_throughput: provisioned_throughput,
      table_name: 'cars'
    )
  end

  def create_items
    client = Dynamodb::Api::Adapter.client
    (@items || default_items).each do |item|
      client.put_item(
        item: item,
        table_name: 'cars'
      )
    end
  end

  def default_items
    [
      { id: '1', maker_id: 1, maker: 'Honda', model: 'Accord', release_date: 19760508 },
      { id: '2', maker_id: 2, maker: 'Toyota', model: 'CROWN', release_date: 19550101 },
      { id: '3', maker_id: 3, maker: 'Tesla', model: 'Model S', release_date: 20120601 },
      { id: '4', maker_id: 1, maker: 'Honda', model: 'S2000', release_date: 19980101 },
    ]
  end

  # MEMO: key_schema, indexで使用する属性だけ記載する
  def attribute_definitions
    [
      {
        attribute_name: 'id',
        attribute_type: 'S',
      },
      {
        attribute_name: 'maker_id',
        attribute_type: 'N',
      },
      {
        attribute_name: 'release_date',
        attribute_type: 'N',
      },
      {
        attribute_name: 'model',
        attribute_type: 'S',
      },
    ]
  end

  def key_schema
    [
      {
        attribute_name: 'id',
        key_type: 'HASH',
      },
    ]
  end

  def global_secondary_indexes
    [
      {
        index_name: 'index_maker_id_release_date',
        key_schema: [
          {
            attribute_name: 'maker_id',
            key_type: 'HASH',
          },
          {
            attribute_name: 'release_date',
            key_type: 'RANGE',
          },
        ],
        projection: {
          projection_type: 'ALL',
        },
        provisioned_throughput: {
          read_capacity_units: 5,
          write_capacity_units: 5,
        },
      },
      {
        index_name: 'index_maker_id_model',
        key_schema: [
          {
            attribute_name: 'maker_id',
            key_type: 'HASH',
          },
          {
            attribute_name: 'model',
            key_type: 'RANGE',
          },
        ],
        projection: {
          projection_type: 'ALL',
        },
        provisioned_throughput: {
          read_capacity_units: 5,
          write_capacity_units: 5,
        },
      },
    ]
  end

  def provisioned_throughput
    {
      read_capacity_units: 5,
      write_capacity_units: 5,
    }
  end
end
