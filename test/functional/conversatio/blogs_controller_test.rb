require File.dirname(__FILE__) + '/../../test_helper'

class Conversatio::BlogsControllerTest < ActionController::TestCase

  context "Given a Blog" do
    setup do
      @controller = Conversatio::BlogsController.new
      @request    = ActionController::TestRequest.new
      @response   = ActionController::TestResponse.new

      @member_user = Factory(:user, :login => 'member_user', :admin => true)
      @blog = Factory(:blog, :title => 'My Blog', :description => 'Cool description', :author => @member_user)
      @bloggership = Factory(:bloggership, :user => @member_user, :blog => @blog)
      @post = Factory(:post, :title => 'My post', :body => 'bla, bla, bla...', :user => @member_user, :blog => @blog)
      @post.publish!
      Factory(:post, :title => 'My draft post', :body => 'bla, bla, bla...', :user => @member_user, :blog => @blog)
    end

    context "on GET to :index" do
      setup do
        get :index
      end

      should_assign_to :blogs

      should_respond_with :success
      should_render_template :index
    end

    context "on GET to :show" do
      setup do
        Factory(:post, :title => 'Other post', :body => 'bla, bla, bla...', :user => @member_user, :blog => @blog)
        get :show, :id => @blog.id
      end

      should_assign_to(:blog) { @blog }
      should_assign_to(:posts) { @blog.posts.published }

      should_respond_with :success
      should_render_template :show
    end
  end

end