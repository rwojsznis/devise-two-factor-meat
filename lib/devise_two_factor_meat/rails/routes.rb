module ActionDispatch::Routing
  class Mapper

    protected

    def devise_otp_challenge(mapping, controllers)
      resource :otp_challenge, :only => [:show, :update], :path => mapping.path_names[:otp_challenge], :controller => controllers[:otp_challenge]
    end
  end
end
