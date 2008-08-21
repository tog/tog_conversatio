# == Schema Information
# Schema version: 1
#
# Table name: blogs
#
#  id         :integer(11)   not null, primary key
#  blog_id    :integer(11)
#  title      :string(255)
#  body       :text
#  user_id    :integer(11)
#  created_at :datetime
#  updated_at :datetime
#

class Conversatio::Post < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable
  seo_urls
  
  belongs_to :blog
  belongs_to :user

  validates_presence_of :title, :body

  acts_as_state_machine :initial => :draft

  state :draft
  state :published

  event :published do
    transitions :from => [:draft] , :to => :published
  end

  event :draft do
    transitions :from => [:published] , :to => :draft
  end

  def owner
    user
  end
end
