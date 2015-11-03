class AccountsController < ApplicationController
  skip_before_action :authorize

  def new
    @account = Account.new
  end

  def create

    # Sanitizing user input, excludes email and password
    raw_account_params = params[:account]
    account_params = {}
    raw_account_params.each do |key, value|
      if key == :password || key == :email
        account_params[key] = value
      else
        account_params[key] = value.sanitize
      end
    end

    if account_params[:password] == account_params[:password_confirmation]
      a = Account.new(
        first_name: account_params[:first_name],
        last_name: account_params[:last_name],
        user_name: account_params[:user_name],
        zip: account_params[:zip],
        description: account_params[:description],
        age: account_params[:age],
        gender: account_params[:gender],
        looking_for: account_params[:looking_for],
        email: account_params[:email],
        password: account_params[:password]
      )

      if a.save
        flash[:alert] = "Successfully created account!"
        return redirect_to "/sign_in"
      else
        #TODO: get this part working
        puts a.errors.inspect
        return render action: 'new'
      end
    end
  end

end
