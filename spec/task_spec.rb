require 'spec_helper'

describe Parsers::Task do
  let(:parser) { Object.new }
  let(:source) { 'http://strizhak-group.ru/' }
  let(:task) do
    Parsers::Task.new(
      parser: parser, method: :test, url: source, data: {}
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

      it 'should visit url which is specified' do
        task.execute
        expect(task.page.current_url).to eq(source)
      end
    end
  end

  it 'Parsers::Task#show: displays the data of current task' do
    allow(PP).to receive(:pp).and_return(task.inspect)
    expect(task.show).to eq(task.inspect)
  end
end
