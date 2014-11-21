module OnSIP
  module ResponseParser

    module ClassMethods
      def parse_response(response, key_path = [], ignore_result_keys = [])
        result = []

        return result unless response && !response.env.body.blank?

        r = response.env.body

        key_path.each_with_index do |key, i|
          if i < (key_path.length - 1) && r[key]
            r = r[key]
          elsif i == (key_path.length - 1) && r[key] && r[key].kind_of?(Array)
            a = r[key]
            result = a.flatten.map { |h| h.delete_if { |k| ignore_result_keys.include?(k) }; h }
          elsif i == (key_path.length - 1) && r[key] && r[key].kind_of?(Hash)
            h = r[key]
            h.delete_if { |k| ignore_result_keys.include?(k) }
            result = [h]
          else
            break
          end
        end

        result
      rescue StandardError => e
        raise OnSIPRequestException.new(:message => 'Problem with parsing response',
                                        :exception => e,
                                        :response => response)
      end
    end

    extend ClassMethods

  end
end
