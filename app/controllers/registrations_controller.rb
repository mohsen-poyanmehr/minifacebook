class RegistrationsController < Devise::RegistrationsController

    def after_inactive_sign_up_path_for(resource_or_scope)
        session["user_return_to"] || root_path
        #new_user_registration_path
    end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
