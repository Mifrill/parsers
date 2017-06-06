require('spec_helper')

describe DNSParser::Parser do
  it 'should be true' do
    visit '/'
    expect(page).to have_content('DNS')
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
