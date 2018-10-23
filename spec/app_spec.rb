require 'spec_helper'

describe Parser do
  let(:source) { 'http://strizhak-group.ru' }
  let(:parser) { Parser.build('Test') }

  context 'Parsers#build_parser' do
    it 'should remains initialized parser class' do
      expect(parser.name).to eq('TestParser')
    end
  end

  context 'Parsers#start' do
    # TODO: figured out how to check result of specific thread
    it 'should run current parser while tasks exists' do
      parser.new
    end
  end
end
