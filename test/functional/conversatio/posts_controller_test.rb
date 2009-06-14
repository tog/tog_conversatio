require File.dirname(__FILE__) + '/../../test_helper'

class Conversatio::PostsControllerTest < ActionController::TestCase

  context "Given a Post" do
    setup do
      @controller = Conversatio::PostsController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new

      @member_user = Factory(:user, :login => 'member_user', :admin => true)
      @blog = Factory(:blog, :title => 'My Blog', :description => 'Cool description', :author => @member_user)
      @bloggership = Factory(:bloggership, :user => @member_user, :blog => @blog)
      @post = Factory(:post, :title => 'My post', :body => 'bla, bla, bla...', :user => @member_user, :blog => @blog)
      @post.publish!
    end

    context "on GET to :show" do
      setup do
        get :show, :id => @post.id, :blog_id => @blog.id
      end

      should_assign_to :blog
      should_assign_to :post

      should_respond_with :success
      should_render_template :show
    end
  end

end