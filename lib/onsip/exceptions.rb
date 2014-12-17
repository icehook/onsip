module OnSIP
  module Exceptions
    class OnSIPError < StandardError
      attr_reader :object

      def initialize(object)
        @object = object
      end

      def message
        if @object && @object.kind_of?(Hash)
          @object[:message]
        else
          @object.to_s
        end
      end

      def to_s
        self.message
      end
    end

    class OnSIPRequestError < OnSIPError
      def response
        @object[:response]
      end
    end
  end
end
