class Letter
  attr_accessor :title

  def initialize
    print 'What is the title of the letter? '
    @title = gets.chomp
    @lines = []
    while add_line

    end
  end

  def add_line
    puts 'Add a line: (Blank line to exit)'
    line = gets.chomp
    unless line.empty?
      @lines.push line
      line
    end
  end

  def each
    @lines.each { |line| yield line }
  end
end

letter = Letter.new
letter.each do |line|
  puts "[#{letter.title}] #{line}"
end
