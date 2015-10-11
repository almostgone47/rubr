class CreateAccounts < ActiveRecord::Migration
  def self.up
    puts "--- Accounts ---"
    create_table "accounts" do |t|
      t.timestamps
      t.string      :first_name
      t.string      :last_name
      t.string      :user_name
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
    end
  end

  def self.down
    drop_table "accounts"
  end
end
