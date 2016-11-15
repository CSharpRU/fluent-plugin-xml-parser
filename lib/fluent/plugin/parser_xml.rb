require 'nori'

module Fluent
  module Plugin
    class XmlParser < Parser
      Fluent::Plugin.register_parser('parser_xml', self)

      def configure(conf)
        super

        @parser = Nori.new
      end

      def parse(xml)
        parsed = @parser.parse(xml)

        if block_given?
          yield nil, parsed
        else
          return nil, parsed
        end
      end
    end
  end
end
