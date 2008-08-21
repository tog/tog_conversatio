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

class Conversatio::Blog < ActiveRecord::Base
  seo_urls

  has_many   :posts
  has_many   :last_posts,      :class_name => 'Post', :order => 'created_at DESC'
  has_many   :published_posts, :class_name => 'Post', :order => 'created_at DESC', :conditions => ['state = ?', 'published']
  has_many   :bloggerships,    :dependent => :destroy
  has_many   :users,           :through => :bloggerships
  belongs_to :author,          :class_name => "User", :foreign_key => "author_id"

  validates_presence_of :title
end
