module DeviseTwoFactorMeat
  class OTPChallengeResponse

    delegate :finish, to: :response

    attr_reader :response
    def initialize(resource)
      @response = Rack::Response.new
      @response.redirect "/#{resource.class.to_s.pluralize.downcase}/otp_challenge" # proof of concept
    end
  end
end
