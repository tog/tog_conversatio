class CreateBloggerships < ActiveRecord::Migration
  def self.up
    create_table :bloggerships do |t|
      t.integer   :blog_id
      t.integer   :user_id
      t.string    :rol, :default => "admin"

      t.timestamps
    end
  end

  def self.down
    drop_table :bloggerships
  end
end
