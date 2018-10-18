require 'pstore'

store = PStore.new('employee.pstore')

store.transaction do
  store['params'] = { 'name' => 'Abc', 'age' => 22, 'salary' => 20_000 }

  store.commit

  store.delete(:age)

  # View all key names:
  store.roots

  store.abort
end

require 'yaml/store'
YAML::Store.new('store.yml') # as same as PStore

# file storage
require 'sdbm'

SDBM.open 'my_database' do |db|
  db['foo'] = 'a string'

  # Add / Update Many at Once
  db.update(foo: 'something', bar: 1)

  # Get all Values
  db.each do |k, v|
    puts "Key: #{k}, Value: #{v}"
  end

  # Retrieve Specific Value
  puts db['foo']
end
