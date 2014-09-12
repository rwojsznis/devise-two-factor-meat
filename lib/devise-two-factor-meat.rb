require 'devise-two-factor'
require 'devise_two_factor_meat/strategies/two_factor_steps_authenticatable'
require 'devise_two_factor_meat/hooks/google_authenticator'
require 'devise_two_factor_meat/models/two_factor_authenticatable'
require 'devise_two_factor_meat/rails/routes'

module Devise
  # Session key used in TwoFactorStepsAuthenticatable strategy
  # We will also check this in google_authenticator hook
  mattr_accessor :otp_challenge_key
  @@otp_challenge_key = :otp_challenge

  # How long two-factor remember cookie is valid after successful authentication
  mattr_accessor :otp_remember_token_duration
  @@otp_remember_token_duration = 30.days
end


# Devise.add_module :otp_challengeable, :controller => :otp_challenge, :route => :otp_challenge)
