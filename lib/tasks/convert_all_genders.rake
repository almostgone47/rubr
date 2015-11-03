desc "Loop through all accounts and convert f => female and m => male"
task :convert_genders => :environment do |t|
  start_time = Time.now
  num_converted = 0
  puts "Beginning to convert genders"
  Account.all.find_each do |account|

    # Looking for
    if account.looking_for == "m"
      account.update(looking_for: "male")
      num_converted += 1
    elsif account.looking_for == "f"
      account.update(looking_for: "female")
      num_converted += 1
    end

    # Gender
    if account.gender == "m"
      account.update(gender: "male")
      num_converted += 1
    elsif account.gender == "f"
      account.update(gender: "female")
      num_converted += 1
    end

  end

  runtime = Time.now - start_time
  puts "Converted genders on #{num_converted} accounts in #{runtime} seconds"
end
