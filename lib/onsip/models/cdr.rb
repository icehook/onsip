module OnSIP
  class CDR
    include Model

    def id
      @attributes.CdrId
    end

    module ClassMethods
      def browse(args = {})
        params = args.merge({'Action' => 'CdrBrowse', 'SessionId' => OnSIP.session.id, 'Output' => 'json'})
        response = OnSIP.connection.get('/api', params, {})        
        process_browse_cdrs_response response
      end

      def process_browse_cdrs_response(response)
        users = []
        r = response.env.body['Response']

        if r && r['Result'] && r['Result']['CdrBrowse'] && r['Result']['CdrBrowse']['Cdrs']
          users = if r['Result']['CdrBrowse']['Cdrs']['Cdr'].kind_of?(Array)
            r['Result']['CdrBrowse']['Cdrs']['Cdr'].flatten.collect { |h| new(h) }
          else
            [(new r['Result']['CdrBrowse']['Cdrs']['Cdr'])]
          end
        else
          raise OnSIPRequestException, 'Problem with user request'
        end

        users
      end
    end

    extend ClassMethods

  end
end
