class AddValueToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :value, :integer, null: false
  end
end
