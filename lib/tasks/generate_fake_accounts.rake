desc "Generates Fake Accounts"
task :generate_fake_accounts, [:amount] => :environment do |t, args|
  if !args[:amount]
    amount = 25
  else
    amount = args[:amount].to_i
  end
  puts "Creating #{amount} fake accounts"

  ActiveRecord::Base.logger = Logger.new(STDOUT)

  def get_profile_image
    http = HTTPClient.new
    random_uri = http.get("http://imgur.com/random", :follow_redirect => true)
    uri = random_uri.header.request_uri.request_uri.gsub("/gallery/", "")
    return "http://i.imgur.com/#{uri}.jpg"
  end


  # Get our random texts
  assets = "#{Rails.root}/lib/assets"
  male_names = File.read("#{assets}/male_names.txt").split("\n")
  female_names = File.read("#{assets}/female_names.txt").split("\n")
  last_names = File.read("#{assets}/last_names.txt").split("\n")
  nouns = File.read("#{assets}/nounlist.txt").split("\n")

  total_accounts = Account.count
  amount.times do |i|
    gender = ["m", "f"].sample

    # Randomly choose first name based on gender
    choose_name_from = (gender == "m" ? male_names : female_names)
    first_name = choose_name_from.sample.capitalize

    last_name = last_names.sample.capitalize
    zip = "68502"
    description = "I #{["like", "love", "hate"].sample} #{nouns.sample.pluralize}"
    profile_picture = get_profile_image

    puts "Creating #{first_name} #{last_name} with description '#{description}' and profile_picture #{profile_picture}"
    Account.create!(
      first_name: first_name,
      last_name: last_name,
      gender: gender,
      zip: zip,
      description: description,
      profile_image: profile_picture,
      password: "password",
      user_name: "FakeAccount#{total_accounts+i}",
      email: "sturgeonb4@gmail.com"
    )

    # TODO: add lookingfor, :orientation

  end

end
