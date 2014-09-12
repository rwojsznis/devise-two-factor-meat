# extend standard functionality
module Devise
  module Models
    module TwoFactorAuthenticatable

      def valid_otp_rembember_token?(cookies)
        Devise.secure_compare(otp_remember_token, cookies[:otp_remember_token]) &&
        otp_remember_token_at + Devise.otp_remember_token_duration < Time.current
      end

      def valid_otp_temporary_token?(session)
        Devise.secure_compare(session[Devise.otp_challenge_key], otp_temporary_token)
      end

      def generate_otp_temporary_token
        loop do
          self.otp_temporary_token = Devise.friendly_token
          break if self.class.where(otp_temporary_token: otp_temporary_token).empty?
        end

        save

        otp_temporary_token
      end
    end
  end
end
