require('spec_helper')

describe MyModel do
  it 'should be true' do
    expect(MyModel.new.the_truth).to be true
  end
end

describe 'some stuff which requires js', js: true do
  it 'will use the default js driver' do
    visit('/')
    Capybara::Screenshot.screenshot_and_save_page
  end
end
