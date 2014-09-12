Devise.setup do |config|
  config.warden do |manager|
    manager.default_strategies(scope: :user).unshift :two_factor_steps_authenticatable
  end

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = 1
  config.reconfirmable = true
  config.password_length = 1..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
