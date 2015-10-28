module XapixClient
  class BadConfigurationError < StandardError; end
  class NoConfigurationError < StandardError; end

  class Configuration
    attr_accessor :project_name, :auth_token, :autoload_models
  end

  class << self
    attr_accessor :configuration, :autoloaded_models
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
    self.autoloaded_models = configuration.autoload_models ? autoload_models : []
  end
end
