desc "Loop through and sanitize all sent messages"
task :sanitize_messages => :environment do |t|
  start_time = Time.now

  puts "Sanitizing #{Message.count} messages... "
  Message.all.find_each do |message|
    puts "Sanitizing message #{message.id}"
    puts "Before: #{message.body}"
    sanitized_message = ActionController::Base.helpers.sanitize(message.body)
    puts "After: #{sanitized_message}"
    message.update(body: sanitized_message)
  end
  puts "Sanitized all messages in #{Time.now - start_time} seconds."
end
