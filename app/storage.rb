require 'yaml/store'

module Parser
  class Store
    def initialize(parser)
      @store = YAML::Store.new "tmp/parser_store_#{parser}.yml"
      @mutex = Mutex.new
      @index = 0
    end

    def <<(fields)
      @mutex.synchronize do
        @store.transaction do
          @store[@index.to_s] = fields.to_h
          @store.commit
        end

        @index += 1
      end
    end
  end
end
