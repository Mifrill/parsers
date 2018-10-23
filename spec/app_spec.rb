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
    # TODO: figured out how to check result of specific thread
    it 'should run current parser while tasks exists' do
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

      expect(parser_init.send(:fields).id).to eq(1)
    end
  end
end
