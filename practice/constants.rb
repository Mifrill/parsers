module Kernel
  # Constants defined in Kernel
  A = B = C = D = E = F = 'defined in kernel'.freeze
end

# Top-level or 'global' constants defined in Object
A = B = C = D = E = 'defined at top-level'.freeze

class Super
  # Constants defined in a superclass
  A = B = C = D = 'defined in superclass'.freeze
end

module Included
  # Constants defined in an included module
  A = B = C = 'defined in included module'.freeze
end

module Enclosing
  # Constants defined in an enclosing module
  A = B = 'defined in enclosing module'.freeze

  class Local < Super
    include Included

    # Locally defined constant
    A = 'defined locally'.freeze

    # The list of modules searched, in the order searched
    # [Enclosing::Local, Enclosing, Included, Super, Object, Kernel, BasicObject]
    # (Module.nesting + self.ancestors + Object.ancestors).uniq
    puts A  # Prints "defined locally"
    puts B  # Prints "defined in enclosing module"
    puts C  # Prints "defined in included module"
    puts D  # Prints "defined in superclass"
    puts E  # Prints "defined at top-level"
    puts F  # Prints "defined in kernel"
  end
end
