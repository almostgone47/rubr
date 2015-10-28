#TODO: optimize this file

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
  adjectives = File.read("#{assets}/adjectives.txt").split("\n")
  verbs = File.read("#{assets}/verbs.txt").split("\n")

  amount.times do |i|
    total_accounts = Account.count
    gender = ["male", "female"].sample

    looking_for = ["male", "female"].delete(gender)
    looking_for = looking_for[0]

    # Randomly choose first name based on gender
    choose_name_from = (gender == "male" ? male_names : female_names)
    first_name = choose_name_from.sample.capitalize

    last_name = last_names.sample.capitalize
    zip = "68502"

    # Random descriptions
    only_have_rand = rand(1..15)
    noun = nouns.sample
    verb = verbs.sample
    adjective = adjectives.sample
    rand_descriptions = [
      "I #{["like", "love", "hate"].sample} #{noun.pluralize}",
      "I have #{rand(2..15)} #{noun.pluralize}",
      "I only have #{only_have_rand} #{(only_have_rand > 1 ? noun.pluralize : noun)}",
      "I want some #{noun.pluralize}",
      "I don't want any #{noun.pluralize}",
      "Sometimes I think about #{noun.pluralize}",
      "Sometimes I think about #{noun}",
      "I identify as #{"aeiou".include?(noun[0]) ? "an" : "a"} #{noun}",
      "I like to #{verb}",
      "I only #{verb} with #{(male_names+female_names).sample.capitalize}",
      "I like to #{verb} late at night",
      "My mom likes to #{verb} with me",
      "I never leave home without my #{noun}",
      "I never leave to #{verb} without a #{noun}",
      "I only like #{verb} with #{adjective} #{noun}",
      "I only buy #{adjective} #{noun.pluralize}",
      "I like to #{verb} #{adjective} #{noun.pluralize} late at night",
      "When I #{verb} I like to also #{verb} some #{noun.pluralize}",
      "I #{verb} while I browse the internet",
      "You should #{verb} with me!",
      "I wonder when I will finally find that #{adjective} #{noun}",
      "My uncle said he wants to #{verb} me",
      "My uncle said he wants to #{verb} my #{adjective} #{noun}",
      "Please don't #{verb} me",
      "Only message me if you're #{adjective}",
      "I have a #{noun} collection",
      "I have a collection of #{noun.pluralize}",
      "I'll show you my #{noun}",
      "It's been #{rand(1..10)} years since I've been able to #{verb}",
      "It's been #{rand(1..10)} years since I've wanted to #{verb} a #{noun}",
      "Ask me about my #{adjective} #{noun}",
      "Ask me about my #{noun}"
    ]
    description = rand_descriptions.sample
    age = rand(18..45)
    profile_picture = get_profile_image


    noun = nouns.sample
    adjective = adjectives.sample
    puts "Creating #{first_name} #{last_name} with description '#{description}' and profile_picture #{profile_picture}"
    Account.create!(
      first_name: first_name,
      last_name: last_name,
      gender: gender,
      looking_for: looking_for,
      zip: zip,
      description: description,
      age: age,
      profile_image: profile_picture,
      password: "password",
      user_name: "#{adjective}#{noun}#{total_accounts+i}",
      email: "sturgeonb4@gmail.com",
      fake_account: true
    )
  # Being nice to Imgur
  sleep 1


  # TODO: add orientation

  end

end

desc "Generates new accounts throughout the day"
task :trickle_new_accounts, [:amount] => :environment do |t, args|
  generating_accounts = true
  while generating_accounts == true
    puts "Trickling a new account"
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
    adjectives = File.read("#{assets}/adjectives.txt").split("\n")
    verbs = File.read("#{assets}/verbs.txt").split("\n")

    total_accounts = Account.count
    gender = ["male", "female"].sample

    looking_for = ["male", "female"].delete(gender)
    looking_for = looking_for[0]

    # Randomly choose first name based on gender
    choose_name_from = (gender == "m" ? male_names : female_names)
    first_name = choose_name_from.sample.capitalize

    last_name = last_names.sample.capitalize
    zip = "68502"

    # Random descriptions
    only_have_rand = rand(1..15)
    noun = nouns.sample
    verb = verbs.sample
    adjective = adjectives.sample
    rand_descriptions = [
      "I #{["like", "love", "hate"].sample} #{noun.pluralize}",
      "I have #{rand(2..15)} #{noun.pluralize}",
      "I only have #{only_have_rand} #{(only_have_rand > 1 ? noun.pluralize : noun)}",
      "I want some #{noun.pluralize}",
      "I don't want any #{noun.pluralize}",
      "Sometimes I think about #{noun.pluralize}",
      "Sometimes I think about #{noun}",
      "I identify as #{"aeiou".include?(noun[0]) ? "an" : "a"} #{noun}",
      "I like to #{verb}",
      "I only #{verb} with #{(male_names+female_names).sample.capitalize}",
      "I like to #{verb} late at night",
      "My mom likes to #{verb} with me",
      "I never leave home without my #{noun}",
      "I never leave to #{verb} without a #{noun}",
      "I only like #{verb} with #{adjective} #{noun}",
      "I only buy #{adjective} #{noun.pluralize}",
      "I like to #{verb} #{adjective} #{noun.pluralize} late at night",
      "When I #{verb} I like to also #{verb} some #{noun.pluralize}",
      "I #{verb} while I browse the internet",
      "You should #{verb} with me!",
      "I wonder when I will finally find that #{adjective} #{noun}",
      "My uncle said he wants to #{verb} me",
      "My uncle said he wants to #{verb} my #{adjective} #{noun}",
      "Please don't #{verb} me",
      "Only message me if you're #{adjective}",
      "I have a #{noun} collection",
      "I have a collection of #{noun.pluralize}",
      "I'll show you my #{noun}",
      "It's been #{rand(1..10)} years since I've been able to #{verb}",
      "It's been #{rand(1..10)} years since I've wanted to #{verb} a #{noun}",
      "Ask me about my #{adjective} #{noun}",
      "Ask me about my #{noun}"
    ]
    description = rand_descriptions.sample
    age = rand(18..45)
    profile_picture = get_profile_image


    noun = nouns.sample
    adjective = adjectives.sample
    puts "Creating #{first_name} #{last_name} with description '#{description}' and profile_picture #{profile_picture}"
    Account.create!(
      first_name: first_name,
      last_name: last_name,
      gender: gender,
      looking_for: looking_for,
      zip: zip,
      description: description,
      age: age,
      profile_image: profile_picture,
      password: "password",
      user_name: "#{adjective}#{noun}#{total_accounts+1}",
      email: "sturgeonb4@gmail.com",
      fake_account: true
    )


    # Main sleeper
    # every 1920 seconds is 45 accounts/day
    # every 3456 seconds is 25 accounts/day
    # Random for the element of surprise
    sleep rand(1920..3456)
  end

end
