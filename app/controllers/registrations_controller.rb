class RegistrationsController < DeviseTokenAuth::RegistrationsController
  private
    def sign_up_params
      params.require(:user).permit(:password, 
                                   :password_confirmation, 
                                   :confirm_success_url,
                                   :name, 
                                   :email, 
                                   :facebook_id)
    end

    def account_update_params
      params.require(:user).permit(:password, 
                                   :password_confirmation, 
                                   :name, 
                                   :email, 
                                   :facebook_id)
    end
end