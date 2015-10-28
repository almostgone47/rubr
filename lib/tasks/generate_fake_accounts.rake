desc "Generates Fake Accounts"
task :generate_fake_accounts, [:amount] => :environment do |t, args|
  if !args[:amount]
    amount = 25
  else
    amount = args[:amount].to_i
  end
  puts "Creating #{amount} fake accounts"
  FakeAccountService.generate_account amount

end

desc "Generates new accounts throughout the day"
task :trickle_new_accounts, [:amount] => :environment do |t, args|
  generating_accounts = true
  while generating_accounts == true
    puts "Trickling a new account"
    FakeAccountService.generate_account

    # Main sleeper
    # every 1920 seconds is 45 accounts/day
    # every 3456 seconds is 25 accounts/day
    # Random for the element of surprise
    sleep rand(1920..3456)
  end

end
