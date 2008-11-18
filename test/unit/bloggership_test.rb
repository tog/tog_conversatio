require File.dirname(__FILE__) + '/../test_helper'

class BloggershipTest < Test::Unit::TestCase
  should_belong_to :blog, :user
end
