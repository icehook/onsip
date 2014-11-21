module OnSIP
  class OnSIPException < StandardError
    attr_accessor :options, :exception

    def initialize(options = {})
      @options = options
      @message = @options[:message]
      @exception = @options[:exception]
    end
  end

  class OnSIPRequestException < OnSIPException
    def response
      @options[:response]
    end
  end
end
