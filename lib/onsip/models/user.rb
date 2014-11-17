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

    def addresses
      Address.browse({'UserId' => self.id})
    end

    module ClassMethods
      def browse(account_id)
        params = {'Action' => 'UserBrowse', 'AccountId' => account_id, 'SessionId' => OnSIP.session.id, 'Output' => 'json'}
        response = OnSIP.connection.get('/api', params, {})
        process_browse_user_response response
      end

      def process_browse_user_response(response)
        users = []
        r = response.env.body['Response']

        if r && r['Result'] && r['Result']['UserBrowse'] && r['Result']['UserBrowse']['Users']
          users = if r['Result']['UserBrowse']['Users']['User'].kind_of?(Array)
            r['Result']['UserBrowse']['Users']['User'].flatten.collect { |h| new(h) }
          else
            [(new r['Result']['UserBrowse']['Users']['User'])]
          end
        else
          raise OnSIPRequestException, 'Problem with user request'
        end

        users
      end

      def delete!(user_id)
        params = {'Action' => 'UserDelete', 'SessionId' => OnSIP.session.id, 'UserId' => user_id, 'Output' => 'json'}
        response = OnSIP.connection.get('/api', params, {})
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
        process_edit_user_status_response response
      end

      def process_edit_user_status_response(response)
        user = nil
        r = response.env.body['Response']

        if r && r['Result'] && r['Result']['UserEditStatus'] && r['Result']['UserEditStatus']['User']
          h = r['Result']['UserEditStatus']['User'].delete_if { |key| %w().include?(key) }
          user = new h
        else
          raise OnSIPRequestException, 'Problem with user request'
        end

        user
      end

      def add(organization, attrs = {})
        params = attrs.merge({'Action' => 'UserAdd',
                              'SessionId' => OnSIP.session.id,
                              'OrganizationId' => organization.id,
                              'Domain' => organization.attributes.Domain,
                              'Output' => 'json'})
        response = OnSIP.connection.get('/api', params, {})
        process_add_user_response response
      end

      def process_add_user_response(response)
        user = nil
        r = response.env.body['Response']

        if r && r['Result'] && r['Result']['UserAdd'] && r['Result']['UserAdd']['User']
          h = r['Result']['UserAdd']['User'].delete_if { |key| %w().include?(key) }
          user = new h
        else
          raise OnSIPRequestException, 'Problem with user request'
        end

        user
      end

      def read(user_id)
        response = OnSIP.connection.get('/api', {'Action' => 'UserRead', 'UserId' => user_id, 'SessionId' => OnSIP.session.id, 'Output' => 'json'}, {})
        process_read_user_response response
      end

      def process_read_user_response(response)
        user = nil
        r = response.env.body['Response']

        pp r

        if r && r['Result'] && r['Result']['UserRead'] && r['Result']['UserRead']['User']
          h = r['Result']['UserRead']['User'].delete_if { |key| %w().include?(key) }
          user = new h
        else
          raise OnSIPRequestException, 'Problem with user request'
        end

        user
      end
    end

    extend ClassMethods

  end
end
