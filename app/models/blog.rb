# == Schema Information
# Schema version: 1
#
# Table name: blogs
#
#  id           :integer(11)   not null, primary key
#  title        :string(255)
#  description  :text
#  user_id      :integer(11)
#  created_at   :datetime
#  updated_at   :datetime
#
class Blog < ActiveRecord::Base
  seo_urls

  has_many   :posts
  has_many   :published_posts, :class_name => 'Post', :order => 'published_at DESC', :conditions => ['state = ? and published_at <= ?', 'published', DateTime.now]
  has_many   :bloggerships,    :dependent => :destroy
  has_many   :users,           :through => :bloggerships
  belongs_to :author,          :class_name => "User", :foreign_key => "author_id"

  validates_presence_of :title
end
