desc "Manually responds to messages received with cleverbot queries"
task :respond_to_messages => :environment do |t|
  puts "Beginning to respond to messages"
  total_responses = 0

  real_accounts = Account.where(fake_account: false)
  Account.where(fake_account: true).find_each do |bot|
    real_accounts.find_each do |real|
      messages = bot.messages_with real
      last = messages.last
      if last
        if messages.last.sender_id == real.id
          # They were the last to send a message
          new_response = Unirest.post "localhost:5000/cleverbot", headers:{ "Accept" => "application/json" }, parameters:{ :query => messages.last.body }
          puts new_response.body
          Message.create(
            sender_id: bot.id,
            receiver_id: real.id,
            body: new_response.body,
            sent_at: Time.now
          )
          total_responses += 1
        end
      end
    end
  end

  puts "Done responding to messages!, responded to #{total_responses} messages!"
end

desc "Constantly check and respond to messages"
task :keep_responding_to_messages => :environment do |t|
  checking = true

  while checking == true
    Account.where(fake_account: true).find_each do |bot|
      Account.where(fake_account: false).find_each do |real|
        messages = bot.messages_with real
        last = messages.last
        if last
          if messages.last.sender_id == real.id
            # They were the last to send a message
            new_response = Unirest.post "localhost:5000/cleverbot", headers:{ "Accept" => "application/json" }, parameters:{ :query => messages.last.body }
            puts new_response.body
            Message.create(
              sender_id: bot.id,
              receiver_id: real.id,
              body: new_response.body,
              sent_at: Time.now
            )
          end
        end
      end
    end
    sleep 5
  end

  puts "Done responding to messages!, responded to #{total_responses} messages!"
end
