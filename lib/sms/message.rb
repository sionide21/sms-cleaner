module Sms
  class Message
    attr_reader :node
    def initialize(node)
      @node = node
    end

    def body
      node[:body]
    end

    def date
      Time.at(node[:date].to_i / 1000.0)
    end

    def type
      TYPES.fetch(node[:type])
    end

    def phone_number
      node[:address]
    end

    def name
      node[:contact_name]
    end

    def locked?
      node[:locked] != "0"
    end

    def delete!
      node.remove
    end

    private :node

    TYPES = { sent: "2", received: "1" }.invert
  end
end
