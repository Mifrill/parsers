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
