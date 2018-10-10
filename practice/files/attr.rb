# ruby app/files/attr.rb

class SomeClassReader
  attr_reader :page

  def initialize
    @page = "getter"
  end
end

puts SomeClassReader.new.page # => getter

class SomeClassWriter
  attr_writer :page
end

puts SomeClassWriter.new.page = "setter" # => setter

class SomeClass
  attr_accessor :page
end

some_class = SomeClass.new
some_class.page = "setter & getter"
puts some_class.page # => setter & getter
