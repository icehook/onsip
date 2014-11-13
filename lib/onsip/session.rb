module OnSIP
  class Session

    attr_accessor :attributes

    def initialize(attributes = {})
      @attributes = Hashie::Mash.new attributes
    end

    def id
      @attributes.SessionId
    end

    def user_id
      @attributes.UserId
    end

    def user
      @user ||= User.read(self.user_id)
    end

    def account
      @account ||= self.user.account
    end

    module ClassMethods
      def create(username, password)
        response = OnSIP.connection.get('/api', {'Action' => 'SessionCreate', 'Username' => username, 'Password' => password, 'Output' => 'json'}, {})
        process_create_session_response response
      end

      def process_create_session_response(response)
        session = nil
        r = response.env.body['Response']['Context']

        if r['Request'] && (r['Request']['IsValid'] == 'true') && r['Session']
          h = r['Session'].delete_if { |key| %w().include?(key) }
          session = new h
        else
          raise OnSIPRequestException, 'Problem with session request'
        end

        session
      end
    end

    extend ClassMethods
  end
end
