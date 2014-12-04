module OnSIP
  module Exceptions
    class OnSIPError < StandardError
      attr_reader :object

      def initialize(object)
        @object = object
      end
    end

    class OnSIPRequestError < OnSIPError
      def response
        @object[:response]
      end
    end
  end
end
