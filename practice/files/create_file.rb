require_relative 'base_command'
class CreateFile < BaseCommand
  def initialize(path, content)
    super("Create file: #{path}")
    @path = path
    @content = content
  end

  def execute
    f = File.open(@path, 'w')
    f.write(@content)
    f.close
  end

  def unexecute
    File.delete(@path) if File.exist?(@path)
  end
end
