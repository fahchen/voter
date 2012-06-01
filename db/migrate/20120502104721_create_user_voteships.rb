class CreateUserVoteships < ActiveRecord::Migration
  def change
    create_table :user_voteships do |t|
      t.integer :user_id
      t.integer :vote_id

      t.timestamps
    end
  end
end
