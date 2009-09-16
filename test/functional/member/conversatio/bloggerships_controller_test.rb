require File.dirname(__FILE__) + '/../../../test_helper'


class Member::Conversatio::BloggershipsControllerTest < ActionController::TestCase
  context "BloggershipsController in Member's area" do
    context "without a logged user" do
      setup do
        get :index, :id => 1
      end
      should_redirect_to('new session path') {new_session_path}
    end

    context "with a logged user" do
      setup do
        @member_user  = Factory(:user, :login => 'member_user')
        @related_user = Factory(:user, :login => 'related_user')
        @related_user.profile.add_friend(@member_user.profile)
        @request.session[:user_id] = @member_user.id
      end

      context "given a Blog" do
        setup do
          @blog = Factory(:blog, :title => 'My Blog', :description => 'Cool description', :author => @member_user)
          @bloggership = Factory(:bloggership, :user => @member_user, :blog => @blog)
        end

        context "on GET to :index" do
          setup do
            get :index, :blog_id => @blog.id
          end

          should_respond_with :success
          should_assign_to(:bloggerships) { @blog.bloggerships }
          should_render_template :index
        end

        context "on POST to :create" do
          setup do
            post :create, :blog_id => @blog.id, :bloggership => { :user_id => @related_user.id }
            @bloggerships_created = Bloggership.find(assigns(:bloggership).id)
            assert @bloggerships_created
            assert_equal(@related_user.id, assigns(:bloggership).user_id)
            assert_equal(@blog.id, assigns(:bloggership).blog_id)
          end

          should_assign_to(:blog) { @blog }
          should_assign_to(:bloggership) { Bloggership.find(@bloggerships_created.id) }
          should_set_the_flash_to /add/i
          should_redirect_to('member conversatio blog bloggerships') {member_conversatio_blog_bloggerships_path(@blog)}
        end

        context "on DELETE to :destroy" do
          setup do
            delete :destroy, :blog_id => @blog.id, :id => @bloggership.id
            assert_nil Bloggership.find_by_id(assigns(:bloggership).id)
          end

          should_set_the_flash_to /removed/i
          should_redirect_to('member conversatio blog bloggerships') {member_conversatio_blog_bloggerships_path(@blog)}
        end
      end
    end
  end
end