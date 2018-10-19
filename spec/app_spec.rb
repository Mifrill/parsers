require('spec_helper')

describe Parsers do
  it "Parsers#remote_request" do
    expect(Parsers.remote_request('http://strizhak-group.ru').code).to eq(200)
  end

  it "Parsers#remote_request retries"
end

describe Parsers::DNSParser do
  it 'should be true' do
    visit '/'
    puts "Current browser: #{Capybara.javascript_driver}"
    expect(page).to have_content('')
  end

  it 'map with argument' do
    links = Array.new(4, "https://stackoverflow.com/questions/23695653/can-you-supply-arguments-to-the-mapmethod-syntax-in-ruby")

    def link(tag)
      url = Addressable::URI.parse(tag) # tag = xpath("//a"); a[:href]
      url.path = "123"
    end

    expect(links.map(&self.method(:link))).to match_array(%w(123 123 123 123))

    array = [1,3,5,7,9]
    array.map(&:to_s).map(&proc { |a| a.gsub(/\d+/, "cool") })
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
