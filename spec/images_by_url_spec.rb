require 'spec_helper'

RSpec.describe ImagesByUrl do
  it 'has a version number' do
    expect(ImagesByUrl::VERSION).not_to be nil
  end

  context 'Module::Class.method' do
    let(:result) { ImagesByUrl::ParseImagesByUrl.new }

    it 'does something useful' do
      url = 'http://livetv141.net/'
      links = JSON.parse(result.list_links_images(url))[0]['link']
      puts links
      expect(links).to match(/\.(png|jpg|gif)$/)
    end
  end
end
