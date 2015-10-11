class CreateAccounts < ActiveRecord::Migration
  def self.up
    puts "--- Accounts ---"
    create_table "accounts" do |t|
      t.timestamps
      t.string      :first_name
      t.string      :last_name
      t.string      :user_name,       null: false
      t.string      :city
      t.string      :state
      t.string      :zip
      t.string      :email
      t.boolean     :email_confirmed, default: false
      t.string      :password_digest, null: false
      t.string      :auth_token
      t.string      :description
      t.string      :sign_up_token
      t.datetime    :sign_up_sent_at

      t.string      :longitude
      t.string      :latitude

      t.datetime    :last_active

      # TODO: work on the wording for this, do we call them likes?
      t.integer     :likes,           default: 25

      # This could be a string seperated by something?
      # eg: "male|female|robot" with extra genders and all that included.
      # It could also be an array, probably easier.
      t.string      :looking_for

      # Simply info to put on their profile, we won't make queries based off of these fields.
      # TODO: make sure this is a good idea
      # TODO: check privilege
      t.string      :orientation
      t.string      :gender
    end
  end

  def self.down
    drop_table "accounts"
  end
end
