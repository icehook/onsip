module OnSIP
  class CDR
    include Model

    def id
      @attributes.CdrId
    end

    module ClassMethods
      def browse(args = {})
        params = args.merge({'Action' => 'CdrBrowse', 'SessionId' => OnSIP.session.id, 'Output' => 'json'})
        response = OnSIP.connection.get('/api', params, {})
        yield response if block_given?
        process_browse_cdrs_response response
      end

      def process_browse_cdrs_response(response)
        cdrs = []

        key_path = %w(Response Result CdrBrowse Cdrs Cdr)
        a = ResponseParser.parse_response response, key_path
        cdrs = a.map { |h| new h } if a

        cdrs
      end
    end

    extend ClassMethods

  end
end
