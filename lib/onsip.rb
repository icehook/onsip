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
  autoload :Model, 'onsip/model'
  autoload :Account, 'onsip/models/account'
  autoload :User, 'onsip/models/user'
  autoload :Organization, 'onsip/models/organization'
  autoload :Address, 'onsip/models/address'
  autoload :CDR, 'onsip/models/cdr'

  module ClassMethods
    attr_accessor :session
    attr_writer :logger

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
      @connection = Connection.new(:uri => uri)
    end

    def connection
      @connection
    end

    def options
      @options
    end

    def auth!(username, password)
      @session = Session.create(username, password)
    end
  end

  extend ClassMethods
end
