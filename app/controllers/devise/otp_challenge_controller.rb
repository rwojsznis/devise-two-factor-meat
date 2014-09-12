class Devise::OtpChallengeController < DeviseController
  before_action :redirect_authenticated
  before_action :redirect_invalid

  def show

  end

  def update

  end

  private

  def redirect_authenticated
    redirect_to after_sign_in_path_for(resource) if warden.authenticated?(resource_name)
  end

  def redirect_invalid
    redirect_to root_path unless resource_class.valid_otp_temporary_token?(session)
  end
end
