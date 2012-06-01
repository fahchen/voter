class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :description
      t.integer :vote_id

      t.timestamps
    end
  end
end
