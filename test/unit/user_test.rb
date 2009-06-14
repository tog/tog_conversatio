require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  context "A user" do

    setup do
      @bush  = Factory(:user, :login => 'bush')
      @obama  = Factory(:user, :login => 'obama')

      @economy = Factory(:blog, :title => 'Crisis', :description => 'more', :author => @bush)
      
      @hope = Factory(:blog, :title => 'Hope', :description => 'more', :author => @obama)
      @bush.bloggerships.create(:blog => @hope)
    end
    
    context "that is destroyed" do
      setup do
        @bush.destroy
      end
    
      should "have his blogs removed" do
         assert Blog.find(:all, :conditions => {:author_id => @bush.id}).size, 0 
      end
      
      should "have his bloggerships removed" do
         assert Bloggership.find(:all, :conditions => {:user_id => @bush.id}).size, 0 
      end      
        
    end
  end

end