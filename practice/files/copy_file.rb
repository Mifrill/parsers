require_relative 'base_command'
require 'fileutils'
class CopyFile < BaseCommand
  def initialize(source, target)
    super("Copy file: #{source} to #{target}")
    @source = source
    @target = target
  end

  def execute
    @content = File.read(@target) if File.exist?(@target)
    FileUtils.copy(@source, @target)
  end

  def unexecute
    if !@content.nil?
      f = File.open(@target, 'w')
      f.write(@content)
      f.close
    else
      File.delete(@target)
    end
  end
end
