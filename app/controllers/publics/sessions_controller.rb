# frozen_string_literal: true

class Publics::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_user, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def after_sign_in_path_for(resource)
    end_users_mypage_path
  end

  def reject_inactive_user
    @end_user = EndUser.find_by(params[:end_user][:id])
    if @end_user
      if @end_user.valid_password?(params[:end_user][:password]) && @end_user.is_unsubscribed
        redirect_to new_end_user_session_path
      end
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
