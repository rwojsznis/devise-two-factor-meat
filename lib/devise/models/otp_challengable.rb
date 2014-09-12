module Devise
  module Models
    module OtpChallengable
      extend ActiveSupport::Concern

      module ClassMethods
        def resource_from_otp_temporary_token(session)
          token = session[Devise.otp_challenge_key]

          return false if token.blank?

          where(otp_temporary_token: token).first
        end
      end

      def valid_otp_rembember_token?(cookies)
        Devise.secure_compare(otp_remember_token, cookies[:otp_remember_token]) &&
        otp_remember_token_at + Devise.otp_remember_token_duration < Time.current
      end

      def valid_otp_temporary_token?(session)
        Devise.secure_compare(session[Devise.otp_challenge_key], otp_temporary_token)
      end

      def clear_otp_temporary_token
        update_column(:otp_temporary_token, nil)
      end

      def generate_otp_temporary_token
        loop do
          self.otp_temporary_token = Devise.friendly_token
          break if self.class.where(otp_temporary_token: otp_temporary_token).empty?
        end

        save!

        otp_temporary_token
      end
    end
  end
end
