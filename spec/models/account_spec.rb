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

  ### BEGIN NIL CHECKS ###
  it "should be invalid with nil first_name" do
    account = Account.new(Account.good_params.merge({first_name: nil}))
    expect(account).to be_invalid
  end

  it "should be invalid with nil last_name" do
    account = Account.new(Account.good_params.merge({last_name: nil}))
    expect(account).to be_invalid
  end

  it "should be invalid with nil user_name" do
    account = Account.new(Account.good_params.merge({user_name: nil}))
    expect(account).to be_invalid
  end

  it "should be invalid with nil email" do
    account = Account.new(Account.good_params.merge({email: nil}))
    expect(account).to be_invalid
  end

  it "should be invalid with nil gender" do
    account = Account.new(Account.good_params.merge({gender: nil}))
    expect(account).to be_invalid
  end

  it "should be invalid with nil looking_for" do
    account = Account.new(Account.good_params.merge({looking_for: nil}))
    expect(account).to be_invalid
  end

  it "should be invalid with nil age" do
    account = Account.new(Account.good_params.merge({looking_for: nil}))
    expect(account).to be_invalid
  end

  ### END NIL CHECKS ###


  ### BEGIN FIRST_NAME CHECKS ###

  # We'll want to check for length and not "" eventually

  ### END FIRST_NAME CHECKS ###


  ### BEGIN LAST_NAME CHECKS ###

  # We'll want to check for length and not "" eventually

  ### END LAST_NAME CHECKS ###


  ### BEGIN USER_NAME CHECKS ###

  # TODO: rewrite this
  it "should not be valid if user_name isn't unique" do
    Account.create(Account.good_params)
    account = Account.create(Account.good_params)
    expect(account).to be_invalid
  end

  it "should not be valid if user_name is too long" do
    long_username = "THISISAREALLYLONGUSERNAMEITSSERIOUSLYTOOLONGWHOWOULDMAKEAUSERNAMETHISLONGTHANKGOODNESSFORVALIDATIONS"
    account = Account.new(Account.good_params.merge({user_name: long_username}))
    expect(account).to be_invalid
  end

  ### END USER_NAME CHECKS ###


  ### BEGIN AGE CHECKS ###
  # This might not be a good test. Why not test for hashes,
  # arrays, etc. Just cheking for 1 thing that isn't an int
  # should be good enough. Not sure though.
  it "should not be valid if age is a string" do
    account = Account.new(Account.good_params.merge({age: "this is an age"}))
    expect(account).to be_invalid
  end

  it "should not be valid if age is a float" do
    account = Account.new(Account.good_params.merge({age: 18.1}))
    expect(account).to be_invalid
  end

  it "should not be valid if age is below 18" do
    account = Account.new(Account.good_params.merge({age: 17}))
    expect(account).to be_invalid
  end

  it "should not be valid if age is above 99" do
    account = Account.new(Account.good_params.merge({age: 9001}))
    expect(account).to be_invalid
  end

  ### END AGE CHECKS ###


  ### BEGIN LOOKING_FOR CHECKS ###
  it "should not be valid if looking_for isn't in (male,female,any)" do
    account = Account.new(Account.good_params.merge({looking_for: "none"}))
    expect(account).to be_invalid
  end
  ### END LOOKING_FOR CHECKS ###


  ### BEGIN GENDER CHECKS ###
  it "should not be valid if gender not in (male, female)" do
    account = Account.new(Account.good_params.merge({gender: "robit"}))
    expect(account).to be_invalid
  end
  ### END GENDER CHECKS ###


  ### BEGIN ZIP CHECKS ###
  it "should not be valid if zip not in correct format" do
    account = Account.new(Account.good_params.merge({zip: "6_8_5_0_2"}))
    expect(account).to be_invalid
  end
  ### END ZIP CHECKS ###


  ### BEGIN EMAIL CHECKS ###
  it "should not be valid if email not in correct format" do
    account = Account.new(Account.good_params.merge({email: "notanemail.lol.com$$$$.net"}))
    expect(account).to be_invalid
  end
  ### END EMAIL CHECKS ###
end
