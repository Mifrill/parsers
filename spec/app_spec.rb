require('spec_helper')

describe MyModel do
  it 'should be true' do
    expect(MyModel.new.the_truth).to be true
  end
end

describe 'some stuff which requires js', js: true do

  before(:all) do
  end

  it 'will use the default js driver' do

  end

  after(:all) do
  end
end
