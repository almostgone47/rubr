class PagesController < ApplicationController

  def dashboard
    @people = Account.all
  end
end
