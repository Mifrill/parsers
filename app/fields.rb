require 'ostruct'

module Parser
  class Fields
    def initialize
      yield @fields ||= OpenStruct.new
    end

    def fields
      @fields.freeze
      @fields
    end
  end
end
