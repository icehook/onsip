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

    def established?
      @attributes.IsEstablished && @attributes.IsEstablished.downcase == 'true'
    end

    def user
      @user ||= User.read(self.user_id)
    end

    def account
      @account ||= self.user.account
    end

    def destroy!
      session = self.class.destroy!(self.id)
      self.attributes.merge!(session.attributes)
      self
    end

    module ClassMethods
      def create(username, password)
        response = OnSIP.connection.get('/api', {'Action' => 'SessionCreate', 'Username' => username, 'Password' => password, 'Output' => 'json'}, {})
        yield response if block_given?
        process_create_session_response response
      end

      def process_create_session_response(response)
        session = nil

        key_path = %w(Response Context Session)
        a = ResponseParser.parse_response response, key_path
        session = (a.map { |h| new h }).first if a

        session
      end

      def destroy!(session_id)
        response = OnSIP.connection.get('/api', {'Action' => 'SessionDestroy', 'SessionId' => session_id, 'Output' => 'json'}, {})
        yield response if block_given?
        process_destroy_session_response response
      end

      def process_destroy_session_response(response)
        session = nil

        key_path = %w(Response Context Session)
        a = ResponseParser.parse_response response, key_path
        session = (a.map { |h| new h }).first if a

        session
      end
    end

    extend ClassMethods
  end
end
