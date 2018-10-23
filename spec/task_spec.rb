require 'spec_helper'

describe Parser::Task do
  let(:parser) { Object.new }
  let(:source) { 'http://strizhak-group.ru/' }
  let(:task) do
    Parser::Task.new(
      parser: parser, driver: :selenium, method: :test, url: source, data: {}
    )
  end

  context 'Parsers::Task#execute' do
    before do
      allow(parser).to receive(:test).and_return(something: 'testing')
    end

    VCR.use_cassette('source') do
      it 'should returns the result of parser method' do
        expect(task.execute).to eq(something: 'testing')
      end
    end
  end

  it 'Parsers::Task#show: displays the data of current task' do
    allow(PP).to receive(:pp).and_return(task.inspect)
    expect(task.show).to eq(task.inspect)
  end
end
