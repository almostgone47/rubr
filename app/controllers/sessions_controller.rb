class SessionsController < ApplicationController

  def new
    if current_account
      redirect_to dashboard_url
    end
  end

  def create
    email = params[:email].downcase
    account = Account.where(email: email).first

    if account && account.authenticate(params[:password])
      cookies[:auth_token] = account.auth_token
      return redirect_to dashboard_url

    else
      flash.now.alert = "Email or Password Incorrect"
      render "new"
    end
  end

  def destroy
    cookies.clear
    session.clear
    redirect_to sign_in_url
  end
end
