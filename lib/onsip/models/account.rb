module OnSIP
  class Account
    include Model

    def id
      @attributes.AccountId
    end

    def organization_id
      @attributes.OrganizationId
    end

    def organizations
      Organization.browse self.id
    end

    def users(session = nil)
      User.browse self.id
    end

    module ClassMethods
      def read(account_id)
        response = OnSIP.connection.get('/api', {'Action' => 'AccountRead', 'AccountId' => account_id, 'SessionId' => OnSIP.session.id, 'Output' => 'json'}, {})
        process_read_account_response response
      end

      def process_read_account_response(response)
        account = nil
        r = response.env.body['Response']

        if r && r['Result'] && r['Result']['AccountRead'] && r['Result']['AccountRead']['Account']
          h = r['Result']['AccountRead']['Account'].delete_if { |key| %w().include?(key) }
          account = new h
        else
          raise OnSIPRequestException, 'Problem with account request'
        end

        account
      end
    end

    extend ClassMethods

  end
end
