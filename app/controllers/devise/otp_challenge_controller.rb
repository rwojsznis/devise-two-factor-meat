class Devise::OtpChallengeController < DeviseController
  before_action :redirect_authenticated
  before_action :redirect_invalid
  after_action :clear_temporary_tmp_token, only: [:update]

  def show
    @otp_temporary_token = session[Devise.otp_challenge_key]
  end

  def update
    @resource = resource_from_temporary_token

    if @resource.valid_otp?(params[:otp_temporary_token])
      sign_in_and_redirect @resource
    else
      redirect_to root_path, alert: "Invalid OTP"
    end
  end

  private

  def redirect_authenticated
    redirect_to after_sign_in_path_for(resource) if warden.authenticated?(resource_name)
  end

  def redirect_invalid
    redirect_to root_path unless resource_from_temporary_token
  end

  def resource_from_temporary_token
    resource_class.resource_from_otp_temporary_token(session)
  end

  def clear_temporary_tmp_token
    @resource.clear_otp_temporary_token if @resource
    session.delete(Devise.otp_challenge_key)
  end
end
