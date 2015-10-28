# XapixClient

Client to the xapix.io API.

CAUTION: SINCE xapix.io IS STILL IN BETA FOLLOW UP ON xapix.io FEATURE CHANGELOG. THINGS MAY BREAK!

Access xapix.io hosted projects with the ActiveResource based [json_api_client](https://github.com/chingor13/json_api_client) library.

On top xapix_client library, once configured, does set your xapix.io Project's API root URL as site and inject your xapix.io 'Authorization-Token'. Setting `autoload_models = true` will request your Project schema and set up all XapiX model resources for you.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xapix_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xapix_client

## Usage

```ruby
require 'xapix_client'

XapixClient.configure do |config|
  config.project_name = 'YOUR_XAPIX_PROJECT_NAME'
  config.auth_token = 'YOUR_XAPIX_PROJECT_AUTH_TOKEN'
  config.autoload_models = true
end

# Unsure about autoloaded model classes? Uncomment:
#puts "Autoloaded Models: #{XapixClient.autoloaded_models.map(&:name)}"
```

Models need to be named according to the Output Endpoints as defined on XapiX.io Project and subclass `XapixClient::Resource`. On XapiX.io Output Endpoints and raw json:api types names are pluralized and snakecased. Ruby Model class names need to be as `String`s `classify` method would return. `XapixClient.configure.autoload_models = true` handles all this for you but you are free to use `false` and code the model classes your own.

That's it! You're set up! Assuming you have a `Product` resource do `Product.all` or `Product.where('...')` or alike as documented on [json_api_client](https://github.com/chingor13/json_api_client).

## Transactions

This feature currently gets an own section, because there is no json:api spec for that, yet. The discussion is in progress and a `/transactions` route is just one approach being discussed, but the one we go for until the spec has been made. Because of that the implementation was done in a way that does not modify any original `json_api_client` behaviour but only adds methods on top. Be aware that on one of the next major version bumps the feature as it is now may dissappear.

Most common use case for transactions is on dependent resources in an all-or-nothing approach. On the Model you consider the 'nucleus' of your transaction batch you are expected to call method `transactional_create(nucleus_attributes, associated_model_instances)`. The method behaves almost exactly like `create(attributes)`, only you additionally pass an Array of Model instances to be included in the transaction.

Example:

```ruby
# AirShoppingRequest, RequestedFlight, RequestedTraveller and RequestedCabinType are autoloaded Model classes.
# IDS = { ... }
# params = { ... }

AirShoppingRequest.transactional_create({ asrq_id: IDS[:asrq], agent_user_id: 'xapix-travel-inc' }, [
  RequestedFlight.new(params[:flight1].merge(f_id: IDS[:flight1], air_shopping_request_id: IDS[:asrq])),
  RequestedTraveller.new(params[:traveller1].merge(rt_id: IDS[:rt], air_shopping_request_id: IDS[:asrq])),
  RequestedCabinType.new(params[:cabin_type1].merge(rct_id: IDS[:rct], air_shopping_request_id: IDS[:asrq]))
])
```

PS: calling `transactional_create` on what I called 'nucleus' is just syntactic sugar. In fact you can call that on any Model involved in the transaction with no difference.

## Contributing

1. Fork it ( https://github.com/pickledolives/xapix_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
