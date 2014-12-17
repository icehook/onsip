module OnSIP
  class UserAddress
    include Model

    DEFAULT_CALL_TIMEOUT = 60

    def id
      @attributes.Address['AddressId']
    end

    def username
      @attributes.Address['Username']
    end

    def domain
      @attributes.Address['Domain']
    end

    def auth_username
      @attributes.AuthUsername
    end

    def auth_password
      @attributes.AuthPassword
    end

    module ClassMethods
      def browse(args)
        params = args.merge({'Action' => 'UserAddressBrowse', 'SessionId' => OnSIP.session.id, 'Output' => 'json'})
        response = OnSIP.connection.get('/api', params, {})
        yield response if block_given?
        process_browse_user_address_response response
      end

      def process_browse_user_address_response(response)
        addresses = []

        key_path = %w(Response Result UserAddressBrowse UserAddresses UserAddress)
        a = ResponseParser.parse_response response, key_path
        addresses = a.map { |h| new h } if a

        addresses
      end

      def add(user, attrs = {})
        params = { 'Username' => user.attributes.Username,
                   'Domain' => user.attributes.Domain,
                   'Timeout' => DEFAULT_CALL_TIMEOUT }.merge(attrs)

        params = params.merge({ 'Action' => 'UserAddressAdd',
                                'SessionId' => OnSIP.session.id,
                                'OrganizationId' => user.organization_id,
                                'UserId' => user.id,
                                'Output' => 'json' })

        response = OnSIP.connection.get('/api', params, {})
        yield response if block_given?
        process_add_user_address_response response
      end

      def process_add_user_address_response(response)
        address = nil

        key_path = %w(Response Result UserAddressAdd UserAddress)
        a = ResponseParser.parse_response response, key_path
        address = (a.map { |h| new h }).first if a

        address
      end

      # Read a UserAddress
      #
      # reference at http://developer.onsip.com/admin-api/User-Addresses/#user-address-read
      #
      # @example UserAddress.read
      # UserAddress.read(address)
      #
      # @return [ UserAddress ] The found UserAddress.
      def read(address)
        response = OnSIP.connection.get('/api', {'Action' => 'UserAddressRead', 'SessionId' => OnSIP.session.id, 'Address' => address, 'Output' => 'json'}, {})
        yield response if block_given?
        process_read_user_address_response response
      end

      def process_read_user_address_response(response)
        user = nil

        key_path = %w(Response Result UserAddressRead UserAddress)
        a = ResponseParser.parse_response response, key_path
        user = (a.map { |h| new h }).first if a

        user
      end

      # TODO
      def edit(*args)
        raise NotImplementedError
      end

      # TODO
      def delete!(*args)
        raise NotImplementedError
      end

    end

    extend ClassMethods

  end
end
