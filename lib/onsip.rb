require 'logger'
require 'trollop'
require 'multi_json'
require 'awesome_print'
require 'active_support/core_ext'
require 'hashie'
require 'faraday'
require 'faraday_middleware'
require 'onsip/exceptions'
require 'onsip/version'

module OnSIP
  autoload :Connection, 'onsip/connection'
  autoload :Session, 'onsip/session'
  autoload :ResponseParser, 'onsip/response_parser'
  autoload :Model, 'onsip/model'
  autoload :Account, 'onsip/models/account'
  autoload :User, 'onsip/models/user'
  autoload :Organization, 'onsip/models/organization'
  autoload :ExternalAddress, 'onsip/models/external_address'
  autoload :UserAddress, 'onsip/models/user_address'
  autoload :CDR, 'onsip/models/cdr'

  module ClassMethods
    attr_writer :logger, :session

    def logger
      @logger ||= init_logger
    end

    def init_logger
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::DEBUG

      @logger
    end

    def connect(uri, options = {})
      @options = Hashie::Mash.new options
      @connection = Connection.new(options.merge({:uri => uri}))
    end

    def connection
      @connection
    end

    def options
      @options
    end

    def auth!(username, password)
      @username, @password = username, password
      @session = Session.create(@username, @password)
    end

    def session
      if @session && @session.established?
        @session
      elsif @username && @password
        @session = Session.create(@username, @password)
      end
    end

  end

  extend ClassMethods
end
