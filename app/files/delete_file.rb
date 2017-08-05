require_relative 'base_command'
class DeleteFile < BaseCommand
  def initialize(path)
    super("Delete file: #{path}")
    @path = path
  end

  def execute
    return unless File.exist?(@path)
    @content = File.read(@path)
    File.delete(@path)
  end

  def unexecute
    return if @content.empty?
    f = File.open(@path, 'w')
    f.write(@content)
    f.close
  end
end
