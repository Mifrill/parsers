class Foo
  protected

  def prot
    'Hey I am protected of Foo'
  end

  private

  def pri
    'hey I am private of Foo'
  end
end

class SubFoo < Foo
  def call_pri_of_foo
    pri
  end

  def call_prot_of_foo
    prot
  end
end

sub_foo = SubFoo.new
puts sub_foo.call_pri_of_foo
puts sub_foo.call_prot_of_foo

next_sub_foo = SubFoo.new

def next_sub_foo.access_protected(child_of_sub_foo)
  child_of_sub_foo.prot
end

puts next_sub_foo.access_protected(sub_foo)

def next_sub_foo.access_private(child_of_sub_foo)
  child_of_sub_foo.pri
end

begin
  puts next_sub_foo.access_private(sub_foo)
rescue StandardError => e
  puts "#{e.class} #{e.message}"
end
