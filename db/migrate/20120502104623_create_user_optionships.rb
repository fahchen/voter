class CreateUserOptionships < ActiveRecord::Migration
  def change
    create_table :user_optionships do |t|
      t.integer :user_id
      t.integer :option_id

      t.timestamps
    end
  end
end
