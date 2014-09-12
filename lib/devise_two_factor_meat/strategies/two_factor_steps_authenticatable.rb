module Devise
  module Strategies
    class TwoFactorStepsAuthenticatable < Devise::Strategies::DatabaseAuthenticatable

      def authenticate!
        resource = mapping.to.find_for_database_authentication(authentication_hash)

        # Reminder to self:
        # params[scope] # params (form)
        # resource # user
        # cookies # cookie jar

        # Regular database sign in, fall back to DatabaseAuthenticatable
        if validate(resource) { !resource.otp_required_for_login }
          super
        end

        # OTP enabled, we need to check few things here:
        # - if client have valid otp_remember_token cookie - do nothing
        # - otherwise - generate temporary GA challenge token
        # always fall back to DatabaseAuthenticatable
        if validate(resource) { resource.otp_required_for_login }
          unless resource.valid_otp_rembember_token?(cookies)
            cookies.delete(:otp_remember_token)
            session[Devise.otp_challenge_key] = true
          end

          super
        end

        fail(:not_found_in_database) unless resource
      end
    end
  end
end

Warden::Strategies.add(:two_factor_steps_authenticatable, Devise::Strategies::TwoFactorStepsAuthenticatable)
