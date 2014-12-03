module OnSIP
  class User
    include Model

    def id
      @attributes.UserId
    end

    def account_id
      @attributes.AccountId
    end

    def organization_id
      @attributes.OrganizationId
    end

    def status
      @attributes.Status
    end

    def domain
      @attributes.Domain
    end

    def username
      @attributes.Username
    end

    def password
      @attributes.Password
    end

    def auth_username
      @attributes.AuthUsername
    end

    def account
      Account.read self.account_id
    end

    def add(organization = nil)
      self.class.add organization, @attributes
    end

    def delete!
      self.class.delete! self.id
    end

    def organization
      @organization ||= Organization.read(self.organization_id)
    end

    def user_addresses
      UserAddress.browse({'UserId' => self.id})
    end

    module ClassMethods
      def browse(account_id)
        params = {'Action' => 'UserBrowse', 'AccountId' => account_id, 'SessionId' => OnSIP.session.id, 'Output' => 'json'}
        response = OnSIP.connection.get('/api', params, {})
        yield response if block_given?
        process_browse_user_response response
      end

      def process_browse_user_response(response)
        users = []

        key_path = %w(Response Result UserBrowse Users User)
        a = ResponseParser.parse_response response, key_path
        users = a.map { |h| new h } if a

        users
      end

      def delete!(user_id)
        params = {'Action' => 'UserDelete', 'SessionId' => OnSIP.session.id, 'UserId' => user_id, 'Output' => 'json'}
        response = OnSIP.connection.get('/api', params, {})
        yield response if block_given?
        process_delete_user_response response
      end

      def process_delete_user_response(response)
        r = response.env.body['Response']

        if r && r['Context'] && r['Context']['Action'] && r['Context']['Action']
          return true
        else
          raise OnSIPRequestException, 'Problem with user request'
        end
      end

      def edit_status(user_id, attrs = {})
        params = attrs.merge({'Action' => 'UserEditStatus', 'SessionId' => OnSIP.session.id, 'UserId' => user_id, 'Output' => 'json'})
        response = OnSIP.connection.get('/api', params, {})
        yield response if block_given?
        process_edit_user_status_response response
      end

      def process_edit_user_status_response(response)
        user = nil
        r = response.env.body['Response']

        key_path = %w(Response Result UserEditStatus User)
        a = ResponseParser.parse_response response, key_path
        user = (a.map { |h| new h }).first if a

        user
      end

      # Adds a User to an Organization
      #
      # reference at http://developer.onsip.com/admin-api/Users/#user-add
      #
      # @example Add User
      # attrs = {'Username' => 'docs',
      #          'Name' => 'Docs',
      #          'Email' => 'docs@example.onsip.com',
      #          'AuthUsername' => 'example',
      #          'Password' => 'mysuperpassword',
      #          'PasswordConfirm' => 'mysuperpassword'}
      # User.add(organization, attrs)
      #
      # @return [ User ] The created User.
      def add(organization, attrs = {})
        params = attrs.merge({'Action' => 'UserAdd',
                              'SessionId' => OnSIP.session.id,
                              'OrganizationId' => organization.id,
                              'Domain' => organization.attributes.Domain,
                              'Output' => 'json'})
        response = OnSIP.connection.get('/api', params, {})
        yield response if block_given?
        process_add_user_response response
      end

      def process_add_user_response(response)
        user = nil

        key_path = %w(Response Result UserAdd User)
        a = ResponseParser.parse_response response, key_path
        user = (a.map { |h| new h }).first if a

        user
      end

      def read(user_id)
        response = OnSIP.connection.get('/api', {'Action' => 'UserRead', 'UserId' => user_id, 'SessionId' => OnSIP.session.id, 'Output' => 'json'}, {})
        yield response if block_given?
        process_read_user_response response
      end

      def process_read_user_response(response)
        user = nil

        key_path = %w(Response Result UserRead User)
        a = ResponseParser.parse_response response, key_path
        user = (a.map { |h| new h }).first if a

        user
      end
    end

    extend ClassMethods

  end
end
