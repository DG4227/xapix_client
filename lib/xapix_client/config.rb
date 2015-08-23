module XapixClient
  class BadConfigurationError < StandardError; end
  class NoConfigurationError < StandardError; end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :project_name, :auth_token
  end
end
