require 'yaml/store'

module Parser
  class Storage
    attr_reader :storage

    def initialize(parser)
      @storage = YAML::Store.new "tmp/parser_store_#{parser}.yml"
      @mutex   = Mutex.new
      @index   = 1
    end

    def <<(fields)
      @mutex.synchronize do
        storage.transaction do
          storage[@index.to_s] = fields.to_h
          storage.commit
        end

        @index += 1
      end
    end
  end
end
