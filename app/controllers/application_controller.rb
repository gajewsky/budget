# frozen_string_literal: true

# A single point of entry for all the customizations and extensions needed for
# an action controller
class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:avatar]
    devise_parameter_sanitizer.permit :account_update, keys: [:avatar]
  end

  private

  # user_login:devise
  def require_user_signed_in
    return if user_signed_in?

    redirect_to(new_user_session_path, flash: { error: 'You must be signed in to view this page.' })
  end

  def user_ids
    params['users'] || User.ids
  end
end
