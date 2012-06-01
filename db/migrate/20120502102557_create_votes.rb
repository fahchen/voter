class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :title
      t.string :description
      t.boolean :multi
      t.datetime :expiration
      t.integer :minoptions
      t.integer :maxoptions
      t.integer :user_id

      t.timestamps
    end
  end
end
