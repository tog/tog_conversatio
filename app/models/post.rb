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

class Post < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable
  seo_urls

  belongs_to :blog
  belongs_to :user

  named_scope :published, lambda { |*args| { :conditions => ['published_at <= ?', args.first || DateTime.now], :order => 'published_at DESC' } }

#  define_index do
#    indexes :title
#    indexes :body
#    indexes :state
#    
#    #set_property :delta => true
#  end

  validates_presence_of :title, :body

  include AASM
  aasm_column :state
  aasm_initial_state :draft

  aasm_state :draft
  aasm_state :published, :enter => Proc.new {|p| p.published_at = DateTime.now if p.published_at.nil? }

  aasm_event :publish do
    transitions :from => [:draft] , :to => :published
  end
  aasm_event :draft do
    transitions :from => [:published] , :to => :draft
  end

  def owner
    user
  end

  def creation_date(format=:short)
    I18n.l(created_at, :format => format)
  end
  
  #def self.site_search(query, search_options = {})
  #  search query, :conditions => {:state=>'published'}
  #end

  def self.site_search(query, search_options={})
    sql = "%#{query}%"
    Post.published.find(:all, :conditions => ["title like ? or body like ?", sql, sql])
  end

end
