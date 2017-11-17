class RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :create_user, only: [:create]

  def create
    render json: @user_hash, status: 201
  end

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

    def create_user
      user = User.new(sign_up_params)
      password_length = 6
      password = Devise.friendly_token.first(password_length)
      user.password = password
      user.password_confirmation = password
      user.save!
      # Creating a hash with the user and password is the easiest way to send the information.
      @user_hash = { user: user, first_login_password: password }
    end
end