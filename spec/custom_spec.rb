require 'spec_helper'

RSpec.describe ImagesByUrl do
  it 'has a version number' do
    expect(ImagesByUrl::VERSION).not_to be nil
  end

  context 'Module::Class.method' do
    let(:result) { ImagesByUrl::ParseImagesByUrl.new }

    it 'does something useful' do
      VCR.use_cassette('yahoo') do
        url = 'http://yahoo.com'
        links = JSON.parse(result.list_links_images(url)).map { |link| link['link'] }

        expect(links.any?(/\.(png|jpg|gif)$/)).to be_truthy
      end
    end
  end
end

describe Parsers do
  let(:source) { 'http://strizhak-group.ru' }

  it 'should be true' do
    puts "Current driver: #{Capybara.default_driver}"

    VCR.use_cassette('host') do
      visit '/'
      expect(page).to have_content('')
    end
  end

  it 'map with argument' do
    links = Array.new(4, 'https://stackoverflow.com/questions/23695653/can-you-supply-arguments-to-the-mapmethod-syntax-in-ruby')

    def link(tag)
      url = Addressable::URI.parse(tag) # tag = xpath("//a"); a[:href]
      url.path = '123'
    end

    expect(links.map(&method(:link))).to match_array(%w[123 123 123 123])

    array = [1, 3, 5, 7, 9]
    array.map(&:to_s).map(&proc { |a| a.gsub(/\d+/, 'cool') })
  end

  describe 'some stuff which requires js', :js do
    before(:all) do
      page.driver.browser.manage.window.resize_to(1280, 1024)
    end

    it 'will use the default js driver' do
      VCR.use_cassette('host') do
        visit '/'
        sleep(2)
        expect(page).to have_content('')
      end
    end

    it 'nokogiri Test For Upwork' do
      VCR.use_cassette('nokogiri') do
        require 'pp'
        visit "#{source}/nokogiri.html"

        array = []
        find_all('.row').each do |row|
          array << { "#{row.find('.left').text.to_s}": row.find('.right').text.to_s }
        end
        pp array
      end
    end
  end

  after(:all) do
  end
end
