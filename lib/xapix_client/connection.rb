require 'json_api_client'

module XapixClient
  class Connection < JsonApiClient::Connection
    TOKEN = 'Authorization-Token'

    def initialize(options = {})
      fail(XapixClient::NoConfigurationError) if XapixClient.configuration.nil?
      fail(XapixClient::BadConfigurationError) if XapixClient.configuration.project_name.nil?
      super(options.merge(site: "https://app.xapix.io/api/v1/#{XapixClient.configuration.project_name}/"))
    end

    def run(request_method, path, params = {}, headers = {})
      fail(XapixClient::BadConfigurationError) if XapixClient.configuration.auth_token.nil?
      super(request_method, path, params, headers.merge(TOKEN => XapixClient.configuration.auth_token))
    end
  end
end
