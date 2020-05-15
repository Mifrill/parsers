require 'spec_helper'

describe Parser do
  let(:source) { 'https://google.com/' }
  let(:parser) { Parser.build('Test') }

  let(:parser_init) do
    Class.new do
      prepend Parser
      def initialize; end
    end.new
  end

  context 'Parser#build_parser' do
    it 'should remains initialized parser class' do
      expect(parser.name).to eq('TestParser')
    end
  end

  context 'Parser#initialize' do
    it 'should run current parser while tasks exists' do
      expect(Thread).to receive(:new).exactly(1).times.and_return(Thread.new {})
      parser.new
    end

    it 'should not to raised an error for blank method' do
      expect { parser_init }.not_to raise_error(RuntimeError)
    end
  end

  context 'Parser#fields' do
    it 'should set fields' do
      parser_init.send(:fields) do |field|
        field.id = 1
      end

      expect(parser_init.fields.id).to eq(1)
    end
  end

  context 'Driver settings' do
    [:mechanize, :selenium, :cuprite].each do |driver|
      it 'should use xpath to find <body>' do
        Parser::Settings.new(driver)
        expect(Capybara.drivers.include?(driver)).to eq(true)
      end
    end
  end

  context 'Parser#(xpath/at_xpath)' do
    it 'should use xpath to find <body>' do
      VCR.use_cassette('google') do
        expect(Thread).to receive(:new).exactly(1).times.and_return(Thread.new {})
        test_parser = parser.new
        session     = Capybara::Session.new(:selenium)
        session.visit('/')

        allow(test_parser).to receive(:page).and_return(session)
        expect(test_parser.at_xpath('//body')).to be_kind_of(Nokogiri::XML::Element)
      end
    end

    unless Gem.win_platform?
      it 'mechanize driver for non win platform' do
        VCR.use_cassette('google_mechanize') do
          expect(Thread).to receive(:new).exactly(1).times.and_return(Thread.new {})
          Parser::Settings.new(:mechanize)
          test_parser = parser.new
          session     = Capybara::Session.new(:mechanize)
          session.visit('/')

          allow(test_parser).to receive(:page).and_return(session)
          expect(test_parser.xpath('//body')).to be_an(Nokogiri::XML::NodeSet)
        end
      end
    end
  end
end
