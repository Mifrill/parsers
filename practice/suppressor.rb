module OutputSuppressor
  def suppress_output
    original_stdout = $stdout.clone
    original_stderr = $stderr.clone
    $stderr.reopen File.new('/dev/null', 'w')
    $stdout.reopen File.new('/dev/null', 'w')
    yield if block_given?
  ensure
    $stdout.reopen original_stdout
    $stderr.reopen original_stderr
  end
end

class Test
  include OutputSuppressor

  OUTPUT = 123

  def test
    block = -> { OUTPUT }

    puts block.call

    suppress_output do
      puts "this output should be suppressed #{block.call}"
    end
  end
end

Test.new.test
