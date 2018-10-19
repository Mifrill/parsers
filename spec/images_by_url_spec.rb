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
