require File.dirname(__FILE__) + '/../test_helper'

class BloggershipTest < ActiveSupport::TestCase
  should_belong_to :blog, :user
end
