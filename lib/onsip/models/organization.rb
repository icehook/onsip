module OnSIP
  class Organization
    include Model

    def id
      @attributes.OrganizationId
    end

    # Adds a User to the Organization
    #
    # reference at http://developer.onsip.com/admin-api/Users/#user-add
    #
    # @example Add User
    # attrs = {'Username' => 'docs',
    #          'Domain' => 'example.onsip.com',
    #          'Name' => 'Docs',
    #          'Email' => 'docs@example.onsip.com',
    #          'AuthUsername' => 'example',
    #          'Password' => 'mysuperpassword',
    #          'PasswordConfirm' => 'mysuperpassword'}
    # organziation.add_user(attrs)
    #
    # @return [ User ] The created User.
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

      // TODO
      def add(*args)
        raise NotImplementedError
      end

      // TODO
      def edit_contact(*args)
        raise NotImplementedError
      end

      // TODO
      def migrate_domain(*args)
        raise NotImplementedError
      end

      // TODO
      def edit_authenticated(*args)
        raise NotImplementedError
      end
    end

    extend ClassMethods

  end
end
