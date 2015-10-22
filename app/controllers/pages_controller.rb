class PagesController < ApplicationController

  def people
    @people = Account.all
  end


  # move to an api controller
  # TODO: make this a lot better and more secure
  # TODO: make sure it checks if they're allowed to like the account
  def like_person
    puts "Received like person request"
    status = 200
    puts params.inspect
    account_to_like = Account.where(id: params[:rated_person_id]).first
    begin
      if account_to_like
        if !current_account.has_rated? account_to_like
          current_account.like account_to_like
        else
          puts "Account already rated account!"
        end
      else
        puts "No account to like"
      end
    rescue => error
      puts error.inspect
      puts "Rescued"
      status = 727
    end

    respond_to do |format|
      format.json { render json: {"status" => status}}
    end
    return status
  end

  def dislike_person
    puts "Received dislike person request"
    status = 200
    puts params.inspect
    account_to_dislike = Account.where(id: params[:rated_person_id]).first

    begin
      if account_to_dislike
        puts "Valid person to rate"
        if !current_account.has_rated? account_to_dislike
          current_account.dislike account_to_dislike
        else
          puts "Account already rated account!"
        end
      else
        puts "No account to dislike"
      end
    rescue => error
      puts error.inspect
      puts "Rescued"
      status = 727
    end

    respond_to do |format|
      format.json { render json: {"status" => status}}
    end
    return status
  end

  # Get all unrated people (API call from dashboard)
  def get_people
    rated_ids = current_account.ratings.pluck(:id)
    rated_ids.push(current_account.id)
    array = Account.where.not(id: rated_ids).to_a

    respond_to do |format|
      format.json { render json: array}
    end
  end
end
