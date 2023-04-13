class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :from_friend, null: false, foreign_key: { to_table: :users }
      t.references :to_friend, null: false, foreign_key: { to_table: :users }
      t.datetime :accepted_at
      
      t.timestamps
      t.index [:from_friend_id, :to_friend_id], unique: true
    end
  end
end