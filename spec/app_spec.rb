require('spec_helper')

describe DNSParser::Parser do
  it 'should be true' do
    visit '/'
    expect(page).to have_content('DNS')
  end

  describe 'some stuff which requires js', :js do
    before(:all) do
      page.driver.browser.manage.window.resize_to(1280, 1024)
    end

    it 'will use the default js driver' do
      visit '/'
      expect(page).to have_content('DNS')
    end

    after(:all) do
    end
  end
end
