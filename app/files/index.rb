require_relative 'composite_command'
require_relative 'create_file'
require_relative 'delete_file'
require_relative 'copy_file'

cmds = CompositeCommand.new
cmds.add_command(CreateFile.new('file1.txt', "hello world\n"))
cmds.add_command(CopyFile.new('file1.txt', 'file2.txt'))
cmds.add_command(DeleteFile.new('file1.txt'))

cmds.up
p cmds.description
cmds.down
