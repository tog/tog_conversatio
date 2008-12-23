class AddPublishedAtPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :published_at, :datetime

    Post.all.each { |p|
      p.update_attribute(:published_at, p.created_at)
    }
  end

  def self.down
    remove_column :posts, :published_at
  end
end
