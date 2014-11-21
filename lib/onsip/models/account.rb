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

        key_path = %w(Response Result AccountRead Account)
        a = ResponseParser.parse_response response, key_path
        account = (a.map { |h| new h }).first if a

        account
      end
    end

    extend ClassMethods

  end
end
