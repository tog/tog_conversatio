require File.dirname(__FILE__) + '/../test_helper'

class PostTest < ActiveSupport::TestCase
  should_belong_to :blog, :user
  
  should_validate_presence_of :title, :body
  
  context "A Post" do
    
    setup do
      @economy = Factory(:post, :title => 'Crisis', :body => 'more')
      @country = Factory(:post, :title => 'New country', :body => 'more')
      @country.publish!
    end
    
    should "find one result" do
      assert_contains Post.site_search('country'), @country
      
      @stories = Post.site_search('more')
      
      assert_contains @stories, @country 
      assert_does_not_contain @stories, @economy
    end
    
    should "find only published" do
      @posts = Post.published
      assert_contains @posts, @country
      
      assert_does_not_contain @posts, @economy
      
    end
  
  end
end
