class AddCasterCountToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :caster_count, :integer, default: 0

  end
end
