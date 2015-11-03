require "rails_helper"

RSpec.describe Account, :type => :model do
  class Account < ActiveRecord::Base
    def self.good_params
      {
        first_name: "Robert",
        last_name: "Testington",
        user_name: "RobTestington",
        city: "Lincoln",
        state: "Nebraska",
        zip: "68502",
        email: "sturgeonb4@gmail.com",
        email_confirmed: true,
        password: "thisisasecurepassword123",
        description: "I like to test things!",
        gender: "male",
        looking_for: "female",
        age: 20
      }
    end
  end

  it "gives us a hash of parameters that are sure to be good when validating" do
    expect(Account).to respond_to(:good_params)
    expect(Account.good_params).to be_a(Hash)
  end

  it "is a valid account with given parameters" do
    account = Account.new(Account.good_params)
    expect(account).to be_valid
  end

end
