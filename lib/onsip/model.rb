module OnSIP
  module Model

    attr_accessor :attributes, :session

    def initialize(attributes = {})
      @attributes = Hashie::Mash.new attributes
    end

    module ClassMethods

      DEFAULT_OPTIONS = {}

      def merge_params(default_options = {}, options = {})
        merged_params = {}

        default_options.each do |opt,h|
          v = options[opt] || h[:v]
          merged_params[h[:k]] = v
        end

        merged_params
      end

    end

    extend ClassMethods

  end
end
