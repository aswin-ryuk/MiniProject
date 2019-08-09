class RegistrationsController < Devise::RegistrationsController

	def sign_up_params
		params.require(:user).permit(:username, :role, :email, :password, :password_confirmation)
	end

end
