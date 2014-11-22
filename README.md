# OnSIP

A Ruby Gem that can be used for integration with the OnSIP platform.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'onsip'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install onsip

## Usage

```ruby
require 'onsip'

OnSIP.connect('https://api.onsip.com/api')
OnSIP.auth!(<username>, <password>)

account = OnSIP.session.account   # Find the account associated with this session
users = account.users # Find the Users associated with that account
pp users
```

## Contributing

1. Fork it ( https://github.com/icehook/onsip/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
