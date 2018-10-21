require 'spec_helper'

describe Parsers do
  let(:source) { 'http://strizhak-group.ru' }
  let(:parser) { Parsers.build_parser('Test') }

  context 'Parsers#remote_request' do
    it 'should remains rest-client object with status 200' do
      VCR.use_cassette('source') do
        request = Parsers.remote_request(source)
        expect(request.code).to eq(200)
      end
    end

    it 'should retries if source is not found'
  end

  context 'Parsers#build_parser' do
    it 'should remains initialized parser class' do
      expect(parser).to be_a_kind_of(TestParser)
    end

    it 'should contains request method for new parser' do
      VCR.use_cassette('source') do
        expect(parser.request(source)).to be_truthy
      end
    end
  end

  context 'Parsers#start' do
    # TODO: figured out how to check result of specific thread
    it 'should run current parser while tasks exists' do
      parser.start
    end
  end
end
