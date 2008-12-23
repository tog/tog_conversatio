require File.dirname(__FILE__) + '/../test_helper'

class BlogTest < Test::Unit::TestCase
  should_have_many :posts
  should_have_many :published_posts
  should_have_many :bloggerships
  should_have_many :users
  should_belong_to :author

  should_require_attributes :title
end
