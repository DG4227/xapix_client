# XapixClient

Client to the xapix.io API.

CAUTION: SINCE xapix.io IS STILL IN BETA FOLLOW UP ON xapix.io FEATURE CHANGELOG. THINGS MAY BREAK!

Access xapix.io hosted projects with the ActiveResource based [json_api_client](https://github.com/chingor13/json_api_client) library. All xapix_client library does in addition is setting your xapix.io Project's API root URL as site and injecting your xapix.io 'auth_token'.

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

Configure:

```ruby
require 'xapix_client'

XapixClient.configure do |config|
  config.project_name = 'YOUR_XAPIX_PROJECT_NAME'
  config.auth_token = 'YOUR_XAPIX_PROJECT_AUTH_TOKEN'
end
```

Name your Models according to the Endpoints you defined on xapix.io and subclass XapixClient::Resource. You are expected to name your xapix.io Endpoints pluralized while the Model class needs to singularized. This allows compliance with the ActiveResource pattern.

## Example

F.e.: You have a xapix.io Project 'my_shoe_shop', that has auto generated auth_token 'xxxSecretxxx'. You created an Endpoint 'shoes' and did all the setup xapix.io expects. Do:

```ruby
require 'xapix_client'

XapixClient.configure do |config|
  config.project_name = 'my_shoe_shop'
  config.auth_token = 'xxxSecretxxx'
end

class Shoe < XapixClient::Resource
end

# => Next you might want to query like Shoe.all or Shoe.where(...) or alike json_api_client methods.
```

For further usage follow the documentation on [json_api_client](https://github.com/chingor13/json_api_client).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/xapix_client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
