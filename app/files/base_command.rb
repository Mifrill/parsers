class BaseCommand
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute
    raise 'Method "execute" must be implemented!'
  end

  def unexecute
    raise 'Method "unexecute" must be implemented!'
  end
end

attempts = 0
begin
  make_service_call()
rescue Exception
  attempts += 1
  retry unless attempts > 2
  exit 1
ensure
  puts "ensure! #{attempts}"
end
