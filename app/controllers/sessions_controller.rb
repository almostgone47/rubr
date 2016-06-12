class SessionsController < ApplicationController
  layout 'blank'
  skip_before_action :authorize

  def new
    puts "In Sessions#new"
    puts "Params: #{params.inspect}"
    if current_account
      puts "Currently in a session"
      puts "Redirecting to people_url: #{people_url}"
      redirect_to people_url
    end
  end

  def create
    puts "In Sessions#create"
    puts "Params: #{params.inspect}"
    user_name = params[:user_name]
    account = Account.where(user_name: user_name).first

    if account && account.authenticate(params[:password])
      cookies[:auth_token] = account.auth_token
      return redirect_to people_url

    else
      flash.now.alert = "User Name or Password Incorrect"
      render "new"
    end
  end

  def destroy
    puts "In Sessions#destroy"
    cookies.clear
    session.clear
    redirect_to sign_in_url
  end
end
