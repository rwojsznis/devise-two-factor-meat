# Executed every time the user is authenticated (first time in each session).
Warden::Manager.after_authentication do |resource, warden, options|
  if resource.otp_required_for_login && !resource.valid_otp_rembember_token?(warden.cookies) && !warden.request.session[Devise.otp_challenge_key]
    # otp challenge failed?
    # we otp remember token is not valid
    # and we don't change challenge key in session
    # cleanup & logout
    warden.cookies.delete(:otp_remember_token)

    warden.logout(scope)

    throw :warden, scope: scope, message: "challenge failed"
  end

  # else
  # ...
end
