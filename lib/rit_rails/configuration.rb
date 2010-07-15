module RitRails
  class Configuration
    attr_accessor :rit_host, :rit_port, :rit_timeout, :rails_env

    def initialize
      @rit_host = 'localhost'
      @rit_port = 3001
      @rit_timeout = 5
      @rails_env = 'production'
    end
  end

  class << self
    attr_accessor :configuration
  end

  # Configure Rit Rails something like 'config/initializers/rit_rails.rb'
  
  # @example
  #   RitRails.configure do |config|
  #     config.rit_host = 'rit.example.com'
  #     config.rit_port = 8080
  #     config.rit_timeout = 2
  #     config.rails_env = 'staging'
  #   end
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end