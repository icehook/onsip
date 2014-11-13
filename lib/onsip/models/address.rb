module OnSIP
  class Address
    include Model

    DEFAULT_CALL_TIMEOUT = 60

    def id
      @attributes.AddressId
    end

    module ClassMethods
      def browse(args)
        params = args.merge({'Action' => 'UserAddressBrowse', 'SessionId' => OnSIP.session.id, 'Output' => 'json'})
        response = OnSIP.connection.get('/api', params, {})
        process_browse_address_response response
      end

      def process_browse_address_response(response)
        addresss = []
        r = response.env.body['Response']

        if r && r['Result'] && r['Result']['UserAddressBrowse'] && r['Result']['UserAddressBrowse']['UserAddresses']
          addresss = if r['Result']['UserAddressBrowse']['UserAddresses']['UserAddress'].kind_of?(Array)
            r['Result']['UserAddressBrowse']['UserAddresses']['UserAddress'].flatten.collect { |h| new(h) }
          else
            [(new r['Result']['UserAddressBrowse']['UserAddresses']['UserAddress'])]
          end
        else
          raise OnSIPRequestException, 'Problem with address request'
        end

        addresss
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
        process_add_address_response response
      end

      def process_add_address_response(response)
        address = nil
        r = response.env.body['Response']

        ap r

        if r && r['Result'] && r['Result']['UserAddressAdd'] && r['Result']['UserAddressAdd']['UserAddress']
          h = r['Result']['UserAddressAdd']['UserAddress'].delete_if { |key| %w().include?(key) }
          address = new h
        else
          raise OnSIPRequestException, 'Problem with address request'
        end

        address
      end
    end

    extend ClassMethods

  end
end
