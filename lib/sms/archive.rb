require 'nokogiri'

module Sms
  class Archive
    def initialize(content)
      @content = content
    end

    def count
      root_node["count"].to_i
    end

    def messages
      message_nodes.map { |node| Message.new(node) }
    end

    def update_count!
      root_node["count"] = message_nodes.count
    end

    def to_xml
      update_count!
      xml.to_xml
    end

    private

    def root_node
      xml.xpath("smses").first
    end

    def message_nodes
      xml.xpath("smses/sms")
    end

    def xml
      @xml ||= Nokogiri::XML(@content)
    end
  end
end
