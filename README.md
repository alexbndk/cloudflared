# CloudflareDev

This gem provides API access to the Cloudflare developer platform. 

Current support: Cloudflare Images

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cloudflare_dev'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cloudflare_dev

## Usage

Working with Cloudflare Images:

```ruby
client = CloudflareDev::Client.new(api_key: "foo", account_id: "bar", images_hash: "baz")
client.images.delete(file_id: "1234")
client.images.details(file_id: "1234")
client.images.direct_upload_url
client.images.download(file_id: "1234")
client.images.list
client.images.signed_url(file_id: "1234", key: "default_key", expiry_seconds: 60 * 15)
client.images.stats
client.images.update(file_id: "1234", requireSignedURLs: true)
client.images.upload(file: "/path/to/file", requireSignedURLs: true)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/devynbit/cloudflare_dev. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/devynbit/cloudflare_dev/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CloudflareDev project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/devynbit/cloudflare_dev/blob/main/CODE_OF_CONDUCT.md).
