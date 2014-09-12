# Executed every time the user is authenticated (first time in each session).
Warden::Manager.after_authentication do |resource, warden, options|
  if resource.otp_required_for_login && !resource.valid_otp_rembember_token?(warden.cookies)
    if !resource.valid_otp_temporary_token?(warden.request.session)
      # otp challenge failed?
      # we otp remember token is not valid
      # and we don't change challenge key in session
      # cleanup & logout
      warden.cookies.delete(:otp_remember_token)
      warden.logout(scope)

      throw :warden, scope: scope, message: "Unexpected OTP failure"
    else
      # we need fresh OTP

      # This seems like some sane idea
      # we should redirect user to custom otp_challenge_{resource} path
      # and deal with OTP there
      response = Rack::Response.new
      response.redirect "/boo"
      throw :warden, response.finish
    end
  end
end
