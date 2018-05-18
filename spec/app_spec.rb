require('spec_helper')

describe DNSParser::Parser do
  it 'should be true' do
    visit '/'
    expect(page).to have_content('')
  end

  it 'test' do
    puts "Current browser: #{Capybara.javascript_driver}"
    visit 'https://usedcrane.com.au/cranes'
    expect(find_all(:xpath, "//div[@id='root']").first.text).not_to be_empty
  end

  describe 'some stuff which requires js', :js do
    before(:all) do
      page.driver.browser.manage.window.resize_to(1280, 1024)
    end

    it 'will use the default js driver' do
      visit '/'
      sleep(2)
      expect(page).to have_content('')
    end

    it 'nokogiri Test For Upwork' do
      require 'pp'
      visit 'http://strizhak-group.ru/nokogiri.html'

      array = []
      find_all('.row').each do |row|
        array << { "#{row.find('.left').text.to_s}": row.find('.right').text.to_s }
      end
      pp array
    end

    after(:all) do
    end
  end
end
