class User < ActiveRecord::Base
  devise :two_factor_authenticatable, otp_secret_encryption_key: 'encryption_key'

  devise :registerable, :recoverable, :rememberable, :trackable, :validatable
end
