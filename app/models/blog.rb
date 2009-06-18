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
  
  acts_as_taggable
  
  has_many   :posts,           :dependent => :destroy
  has_many   :bloggerships,    :dependent => :destroy
  has_many   :users,           :through => :bloggerships
  belongs_to :author,          :class_name => "User", :foreign_key => "author_id"

  validates_presence_of :title
  
  def self.site_search(query, search_options={})
    sql = "%#{query}%"
    Blog.find(:all, :conditions => ["title like ? or description like ?", sql, sql])
  end
  
  def creation_date(format=:short)
    I18n.l(created_at, :format => format)
  end
    
end
