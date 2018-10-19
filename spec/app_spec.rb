require('spec_helper')

describe Parsers do
  before do
    @source = 'http://strizhak-group.ru'
  end

  context "Parsers#remote_request" do
    it "should remains rest-client object with status 200" do
      request = Parsers.remote_request(@source)
      expect(request.code).to eq(200)
    end

    it "should retries if source if not found"
  end

  context "Parsers#build_parser" do
    before do
      @parser = Parsers.build_parser('DNS')
    end

    it "should remains initialized parser class" do
      expect(@parser).to be_a_kind_of(DNSParser)
    end

    it "should contains request method for new parser" do
      expect(@parser.request(@source)).to be_truthy
    end
  end

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
      visit "#{@source}/nokogiri.html"

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
