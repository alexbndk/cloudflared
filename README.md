# Cloudflared

[![Build Status](https://github.com/devynbit/cloudflared/actions/workflows/main.yml/badge.svg)](https://github.com/devynbit/cloudflared/actions) 
[![Gem Version](https://badge.fury.io/rb/cloudflared.svg)](https://badge.fury.io/rb/cloudflared)

This gem provides API access to the Cloudflare developer platform. 

Current support: Cloudflare Images

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cloudflared'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cloudflared

## Setup 

You will need the following keys from your Cloudflare account: 


## Usage

Working with Cloudflare Images:

```ruby
client = Cloudflared::Client.new(api_key: "foo", account_id: "bar", images_hash: "baz", images_default_hash: "foobar")
client.images.delete(file_id: "1234")
client.images.details(file_id: "1234")
client.images.direct_upload_url
client.images.download(file_id: "1234")
client.images.list
client.images.signed_url(file_id: "1234", expiry_seconds: 60 * 15)
client.images.stats
client.images.update(file_id: "1234", requireSignedURLs: true)
client.images.upload(file: "/path/to/file", requireSignedURLs: true)
```

#### Rails and Pre-configured client settings

If you're using this in rails (or want to pre-configure settings), you can pre-configure the client settings via an initializer by adding the following:

```ruby
# config/initializers/cloudflared.rb
 
Cloudflared.configure do |config|
  config.api_key = "key"
  config.account_id = "key"
  config.images_hash = "key"
  config.images_default_key = "key"
  config.adapter = Faraday.default_adapter  # optional, defaults to Faraday.default_adapter
end
```

If pre-configured, the client is available via the following shortcut: 

```ruby
client = Cloudflared.client
client.images.details(file_id: "1234")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/devynbit/cloudflared. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/devynbit/cloudflared/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Cloudflared project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/devynbit/cloudflared/blob/main/CODE_OF_CONDUCT.md).
