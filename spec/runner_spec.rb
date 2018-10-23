require 'spec_helper'

describe Parser::Runner do
  let(:parser) { Object.new }
  let(:runner) { Parser::Runner.new }
  let(:source) { 'http://strizhak-group.ru/' }

  let(:thread) do
    Class.new do
      def join; end
    end.new
  end

  let(:task) do
    Class.new do
      def execute; end
    end.new
  end

  before do
    allow(Thread).to receive(:new).and_yield.and_return(thread)
    allow(parser).to receive(:test).and_return(something: 'testing')
  end

  VCR.use_cassette('source') do
    context 'Parsers::Runner#add_task' do
      it 'should just add current task into thread pool' do
        runner.add_task(task)

        expect(runner.threads.count).to eq(1)
        expect(runner.queue.size).to eq(1)
        expect(runner.threads.first).to be_a_kind_of(thread.class)
      end
    end

    context 'Parsers::Runner#execute_task' do
      it 'should add worker thread for last added thread' do
        runner.add_task(task)
        runner.add_task_execute

        expect(runner.threads.count).to eq(2)
        expect(runner.queue.size).to    eq(0)
      end

      it "should show message: 'No existed tasks' if no was add_task before"
    end

    context 'Parsers::Runner#run_threads' do
      before do
        runner.add_task(task)
        runner.add_task_execute
      end

      it 'should runner all available threads' do
        expect(runner.threads.count).to eq(2)
        runner.run_threads
        expect(runner.threads.count).to eq(0)
      end
    end

    context 'Parsers::Runner#done?' do
      it 'should return true if no exist available threads' do
        expect(runner.done?).to be true
      end
    end
  end
end
