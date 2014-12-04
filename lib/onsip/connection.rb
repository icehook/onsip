module OnSIP
  class Connection

    USER_AGENT = "onsip-client v#{OnSIP::VERSION}"
    DEFAULT_OPTIONS = {
      :log_response_headers => false,
      :log_response_body => false
    }

    attr_accessor :options, :faraday

    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
      @faraday = self.create_faraday(options[:uri])
    end

    def create_faraday(uri)
      @faraday = Faraday.new uri do |c|
        c.headers['User-Agent'] = USER_AGENT

        c.request :multipart
        c.request :url_encoded

        c.response :json,  :content_type => /\bjson$/
        c.response :mashify
        c.response :logger, OnSIP.logger if @options[:log_response_headers]

        c.use :instrumentation
        c.adapter Faraday.default_adapter
      end
    end

    def request(method, path, params, options, &callback)
      sent_at = nil

      response = @faraday.send(method) { |request|
        sent_at = Time.now
        request = config_request(request, method, path, params, options)
      }.on_complete { |env|
        env[:total_time] = Time.now.utc.to_f - sent_at.utc.to_f if sent_at
        env[:request_params] = params
        env[:request_options] = options
        OnSIP.logger.debug env.body if @options[:log_response_body]
        callback.call(env) if callback
      }

      response
    end

    def config_request(request, method, path, params, options)
      request.headers['Content-Type'] = 'application/json'

      case method.to_sym
      when :delete, :get
        request.url(path, params)
      when :post, :put
        request.path = path
        request.body = MultiJson.dump(params) unless params.empty?
      end

      request
    end

    def get(path, params={}, options={}, &callback)
      request(:get, path, params, options, &callback)
    end

    def delete(path, params={}, options={}, &callback)
      request(:delete, path, params, options, &callback)
    end

    def post(path, params={}, options={}, &callback)
      request(:post, path, params, options, &callback)
    end

    def put(path, params={}, options={}, &callback)
      request(:put, path, params, options, &callback)
    end

  end
end
