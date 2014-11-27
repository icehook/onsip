module OnSIP
  class ExternalAddress
    include Model

    module ClassMethods
      # TODO
      def add(*args)
        raise NotImplementedError
      end

      # TODO
      def read(*args)
        raise NotImplementedError
      end

      def browse(args)
        params = args.merge({'Action' => 'ExternalAddressBrowse', 'SessionId' => OnSIP.session.id, 'Output' => 'json'})
        response = OnSIP.connection.get('/api', params, {})
        yield response if block_given?
        process_browse_external_address_response response
      end

      def process_browse_external_address_response(response)
        external_addresses = []

        key_path = %w(Response Result ExternalAddressBrowse ExternalAddresses ExternalAddress)
        a = ResponseParser.parse_response response, key_path
        external_addresses = a.map { |h| new h } if a

        external_addresses
      end

      # TODO
      def delete!(*args)
        raise NotImplementedError
      end

      # TODO
      def edit(*args)
        raise NotImplementedError
      end
    end

    extend ClassMethods

  end
end
