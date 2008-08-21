class AddStateToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :state, :string
  end

  def self.down
    remove_column :posts, :state
  end
end
