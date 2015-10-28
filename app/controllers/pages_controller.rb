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
      status = 500
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
      status = 500
    end

    respond_to do |format|
      format.json { render json: {"status" => status}}
    end
    return status
  end

  # Get all unrated people (API call from dashboard)
  def get_people
    begin
      cur_account = current_account
      puts "-----------"
      puts "Request for people by user #{cur_account.id}"

      rated_ids = cur_account.ratings.pluck(:id)
      rated_ids.push(cur_account.id)

      looking_for = cur_account.looking_for
      if looking_for == "any"
        looking_for = ["male", "female"]
      end

      people = Account.where(gender: cur_account.looking_for).where.not(id: rated_ids).to_a

      # Only pass certain params that the page will use
      # TODO: write this better
      people_data = []
      people.each do |person|
        person_struct = {
            id: person.id,
            profile_image: person.profile_image,
            age: person.age,
            description: person.description,
            username: person.user_name
        }
        people_data.push(person_struct)
      end

      puts "Retrieved #{people.count} people"
      puts "-----------"

      respond_to do |format|
        format.json { render json: people }
      end

    rescue => e
      puts "Error getting people"
      puts e.inspect
      render :status => 500
    end


  end
end
