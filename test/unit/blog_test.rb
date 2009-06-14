require File.dirname(__FILE__) + '/../test_helper'

class BlogTest < ActiveSupport::TestCase
  should_have_many :posts
  should_have_many :bloggerships
  should_have_many :users
  should_belong_to :author

  should_validate_presence_of :title
  
  context "A Blog" do
    
    setup do
      @economy = Factory(:blog, :title => 'Crisis', :description => 'more')
      @country = Factory(:blog, :title => 'New country', :description => 'more')
    end

    should "should be equal" do
      assert @economy.title, 'Crisis'
    end
    
    should "should find one result" do
      assert_contains Blog.site_search('Crisis'), @economy

      @stories = Blog.site_search('country')

      assert_contains @stories, @country
      assert @stories.size, 1 
    end
    
    should "should find two result" do
      @stories = Blog.site_search('more')
      
      assert_contains @stories, @economy
      assert_contains @stories, @country
      
      assert @stories.size, 2
    end
  
  end

end
