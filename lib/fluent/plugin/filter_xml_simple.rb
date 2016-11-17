require 'nori'

module Fluent
  class XmlFilter < Filter
    Fluent::Plugin.register_filter('xml_simple', self)

    config_param :fields, :string

    def configure(conf)
      super

      raise ConfigError, "'Fields' is required" if self.fields.nil?

      self.fields = self.fields.split(',')

      raise ConfigError, "'Fields' must contain at least one key" if self.fields.length < 1
    end

    def start
      super

      @parser = Nori.new(:advanced_typecasting => false)
    end

    def shutdown
      super

      @parser = nil
    end

    def filter(tag, time, record)
      self.fields.each { |field|
        if record.key?(field)
          record[field] = @parser.parse(record[field])
        end
      }

      record
    end
  end
end