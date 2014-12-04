module OnSIP
  module ResponseParser

    module ClassMethods
      include ::OnSIP::Exceptions

      def parse_response(response, key_path = [], ignore_result_keys = [])
        begin

          if valid_response?(response)
            value_at_key_path(response.env.body, key_path, ignore_result_keys)
          else
            raise StandardError, 'Problem validating OnSIP response'
          end

        rescue StandardError => e
          raise OnSIPRequestError.new(:message => 'Problem with parsing response',
                                      :exception => e,
                                      :response => response)
        end
      end

      def valid_response?(response)
        if response && response.env[:status] == 200 && !response.env.body.blank?
          r = response.env.body
          r['Response']['Context']['Action']['IsCompleted'] == 'false' ? false : true
        else
          false
        end
      end

      def value_at_key_path(body, key_path = [], ignore_result_keys = [])
        result = []

        key_path.each_with_index do |key, i|
          if i < (key_path.length - 1) && body[key]
            body = body[key]
          elsif i == (key_path.length - 1) && body[key] && body[key].kind_of?(Array)
            a = body[key]
            result = a.flatten.map { |h| h.delete_if { |k| ignore_result_keys.include?(k) }; h }
          elsif i == (key_path.length - 1) && body[key] && body[key].kind_of?(Hash)
            h = body[key]
            h.delete_if { |k| ignore_result_keys.include?(k) }
            result = [h]
          else
            break
          end
        end

        result
      end

    end

    extend ClassMethods

  end
end
