module OnSIP
  module Model

    attr_accessor :attributes, :session

    def initialize(attributes = {})
      @attributes = Hashie::Mash.new attributes
    end

    module ClassMethods

    end

    extend ClassMethods

  end
end
