class CompositeCommand
  def initialize
    @commands = []
  end

  def add_command(command)
    @commands << command
  end

  def up
    @commands.each(&:execute)
  end

  def down
    @commands.reverse.each(&:unexecute)
  end

  def description
    @commands.inject([]) { |result, cmd| result << cmd.description }.join(' -> ')
  end
end
