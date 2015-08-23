require 'json_api_client'

module XapixClient
  class Resource < JsonApiClient::Resource
    self.connection_class = XapixClient::Connection
  end
end
