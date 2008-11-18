require File.dirname(__FILE__) + '/../test_helper'

class PostTest < Test::Unit::TestCase
  should_belong_to :blog, :user
  
  should_require_attributes :title, :body
end
