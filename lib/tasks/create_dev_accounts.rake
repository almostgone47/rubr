desc "Creates Development Accounts"
task :create_dev_accounts => :environment do
  ActiveRecord::Base.logger = Logger.new(STDOUT)

  Account.create!(
    first_name: "Admin",
    last_name: "Admin",
    user_name: "Admin",
    city: "Lincoln",
    state: "Nebraska",
    email_confirmed: true,
    password: "admin",
    description: "I'm an admin.",
    email: "sturgeonb4@gmail.com"
  )

end
