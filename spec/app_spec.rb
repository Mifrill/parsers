require 'spec_helper'

describe Parser do
  let(:source) { 'http://strizhak-group.ru' }
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

    it 'should bot to raised an error if the initialize method is no contains task' do
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

  context 'Parser#xpath' do
    it 'should use xpath to find <body>' do
      VCR.use_cassette('host') do
        expect(Thread).to receive(:new).exactly(1).times.and_return(Thread.new {})
        test_parser = parser.new
        session     = Capybara::Session.new(:selenium)
        session.visit('/')

        allow(test_parser).to receive(:page).and_return(session)
        expect(test_parser.xpath('//body')).to be_truthy
      end
    end
  end
end
