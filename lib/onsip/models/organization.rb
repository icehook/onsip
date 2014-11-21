module OnSIP
  class Organization
    include Model

    def id
      @attributes.OrganizationId
    end

    def add_user(attrs = {})
      User.add self, attrs
    end

    module ClassMethods
      def browse(account_id)
        params = {'Action' => 'OrganizationBrowse', 'AccountId' => account_id, 'SessionId' => OnSIP.session.id, 'Output' => 'json'}
        response = OnSIP.connection.get('/api', params, {})
        process_browse_organization_response response
      end

      def process_browse_organization_response(response)
        organizations = []

        key_path = %w(Response Result OrganizationBrowse Organizations Organization)
        a = ResponseParser.parse_response response, key_path
        organizations = a.map { |h| new h } if a

        organizations
      end

      def read(organization_id)
        params = {'Action' => 'OrganizationRead', 'OrganizationId' => organization_id, 'SessionId' => OnSIP.session.id, 'Output' => 'json'}
        response = OnSIP.connection.get('/api', params, {})
        process_read_organization_response response
      end

      def process_read_organization_response(response)
        organization = nil

        key_path = %w(Response Result OrganizationRead Organization)
        a = ResponseParser.parse_response response, key_path
        organization = (a.map { |h| new h }).first if a

        organization
      end
    end

    extend ClassMethods

  end
end
