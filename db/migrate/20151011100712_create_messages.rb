class CreateMessages < ActiveRecord::Migration
  def self.up
    puts "--- Messages ----"
    create_table "messages" do |t|
      t.timestamps
      t.text        :body,    null: false
      t.datetime    :sent_at
      t.boolean     :read,    default: false
      t.datetime    :read_at
      t.integer     :sender_id
      t.integer     :receiver_id
    end
  end

  def self.down
    drop_table "messages"
  end
end
