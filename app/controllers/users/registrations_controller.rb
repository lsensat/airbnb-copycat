# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    # super
    @user = current_user
    if params[:user][:password].present?
      if @user.valid_password?(params[:user][:current_password])
        # Update the password
        @user.update(user_params)
        # Continue with your logic or redirect
        redirect_to root_path
      else
        # Handle incorrect current password
        flash[:alert] = 'Current password is incorrect.'
        render :edit
      end
    else
      # Update other attributes (excluding password-related changes)
      @user.update(account_update_params.except(:current_password, :password, :password_confirmation))
      # Continue with your logic or redirect
      redirect_to edit_user_password_path(current_user)
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  private

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :photo)
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
