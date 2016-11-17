require 'nori'

module Fluent
  class XmlFilter < Filter
    Fluent::Plugin.register_filter('xml_simple', self)

    config_param :fields, :string

    config_param :try_convert_times, :bool, :default => true # try to convert values in hash to times
    config_param :time_format, :string, :default => nil
    config_param :field_name_postfix, :string, :default => 'hash' # if set will create hash in new field with postfix (xml => xml_hash)

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
          field_name = field

          if self.field_name_postfix
            field_name = [field, self.field_name_postfix].join '_'
          end

          hash = @parser.parse(record[field])
          hash = self.try_convert_times ? convert_times(hash) : hash

          $log.debug "Hash from XML: #{hash.to_s}"

          record[field_name] = hash
        end
      }

      record
    end

    private

    def convert_times(hash)
      hash.each { |key, value|
        value.class == Hash ? convert_times(value) : try_to_convert(value) { |x|
          self.time_format ? Time.strptime(x, self.time_format) : Time.parse(x)
        }
      }
    end

    def try_to_convert(value, &block)
      block.call(value)
    rescue Exception => e
      $log.debug "Cannot convert time: #{e.message}\nTrace: #{e.backtrace.to_s}"
    end
  end
end