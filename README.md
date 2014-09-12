# Devise::Two::Factor::Meat

Meat to the barebones provided by [devise-two-factor][1].

## Installation

Add this line to your application's Gemfile:

    gem 'devise-two-factor-meat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install devise-two-factor-meat

## Workflow (WIP)

The workflow is inspired by Github, meaning you first provide your email (login, or whatever your system is using) & password and later or OTP if it's required - you have one try to provide valid OTP, if it's invalid you have enter your credentials all over again.

1. User without two-factor authentication.
- log-in using valid email & password => user is logged-in

2. User with two-factor authentication
- log-in using valid email & password
  - remember token for one-time-password exists, is valid and not expired? => user is logged in
  - remember token is invalid, expired or doesn't exist
    - generate temporary otp id, save it in database & in user's session
    - ask for OTP:
      - temporary otp id from session matches the one from db:
        - OTP is valid? => user is logged in
        - OTP is invalid => go to start
      - temporary otp id doesn't match => go to start

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/devise-two-factor-meat/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[1]: https://github.com/tinfoil/devise-two-factor
