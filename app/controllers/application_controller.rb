class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  # Gets the current account based on auth_token cookie
  def current_account
    @current_account ||= Account.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_account

  # If they're not logged in, send 'em to the sign_in_url
  def authorize
    unless current_account
      return redirect_to sign_in_url
    end
  end
end
