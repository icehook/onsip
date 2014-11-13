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
        r = response.env.body['Response']

        if r && r['Result'] && r['Result']['OrganizationBrowse'] && r['Result']['OrganizationBrowse']['Organizations']
          organizations = if r['Result']['OrganizationBrowse']['Organizations']['Organization'].kind_of?(Array)
            r['Result']['OrganizationBrowse']['Organizations']['Organization'].flatten.collect { |h| new(h) }
          else
            [(new r['Result']['OrganizationBrowse']['Organizations']['Organization'])]
          end
        else
          raise OnSIPRequestException, 'Problem with organization request'
        end

        organizations
      end

      def read(organization_id)
        params = {'Action' => 'OrganizationRead', 'OrganizationId' => organization_id, 'SessionId' => OnSIP.session.id, 'Output' => 'json'}
        response = OnSIP.connection.get('/api', params, {})
        process_read_organization_response response
      end

      def process_read_organization_response(response)
        organization = nil
        r = response.env.body['Response']

        if r && r['Result'] && r['Result']['OrganizationRead'] && r['Result']['OrganizationRead']['Organization']
          h = r['Result']['OrganizationRead']['Organization'].delete_if { |key| %w().include?(key) }
          organization = new h
        else
          raise OnSIPRequestException, 'Problem with organization request'
        end

        organization
      end
    end

    extend ClassMethods

  end
end
