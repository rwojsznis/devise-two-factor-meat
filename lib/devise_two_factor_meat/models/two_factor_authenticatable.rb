# extend standard functionality
module Devise
  module Models
    module TwoFactorAuthenticatable
      def valid_otp_rembember_token?(cookies)
        Devise.secure_compare(otp_remember_token, cookies[:otp_remember_token]) &&
        otp_remember_token_at + Devise.otp_remember_token_duration < Time.current
      end
    end
  end
end
