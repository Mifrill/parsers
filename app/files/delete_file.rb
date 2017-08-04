require_relative 'base_command'
class DeleteFile < BaseCommand
  def initialize(path)
    super("Delete file: #{path}")
    @path = path
  end

  def execute
    if File.exist?(@path)
      @content = File.read(@path)
      File.delete(@path)
    end
  end

  def unexecute
    return if @content.empty?
    f = File.open(@path, 'w')
    f.write(@content)
    f.close
  end
end
