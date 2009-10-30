require File.dirname(__FILE__) + '/../../../test_helper'


class Member::Conversatio::PostsControllerTest < ActionController::TestCase
  context "PostsController in Member's area" do
    context "without a logged user" do
      setup do
        get :index, :id => 1
      end
      should_redirect_to('new session path') {new_session_path}
    end

    context "with a logged user" do
      setup do
        @member_user = Factory(:user, :login => 'member_user')
        @request.session[:user_id] = @member_user.id
      end

      context "given a Blog" do
        setup do
          @blog = Factory(:blog, :title => 'My Blog', :description => 'Cool description', :author => @member_user)
          @bloggership = Factory(:bloggership, :user => @member_user, :blog => @blog)
          @post = Factory(:post, :title => 'My post', :body => 'bla, bla, bla...', :user => @member_user, :blog => @blog)
          @post.publish!
        end

        context "on GET to :index" do
          setup do
            get :index, :blog_id => @blog.id
          end

          should_respond_with :success
          should_assign_to(:blog) { @blog }
          should_render_template :index
        end

        context "on GET to :show" do
          setup do
            get :show, :blog_id => @blog.id, :id => @post.id
          end

          should_respond_with :success
          should_assign_to(:blog) { @blog }
          should_assign_to(:post) { @post }
          should_assign_to(:comments) { @post.all_comments }
          should_render_template :show
        end

        context "on GET to :new" do
          setup do
            get :new, :blog_id => @blog.id
            assert_equal(true, assigns(:post).new_record?)
          end

          should_respond_with :success
          should_assign_to(:blog) { @blog }
          should_assign_to :post
          should_render_template :new
        end

        context "on GET to :edit" do
          setup do
            get :edit, :blog_id => @blog.id, :id => @post
          end

          should_respond_with :success
          should_assign_to(:blog) { @blog }
          should_assign_to(:post) { @post }
          should_render_template :edit
        end

        context "on POST to :create with correct data" do
          setup do
            post :create, :blog_id => @blog.id, :post => { :title => 'New Post', :body => 'Cool body' }, :state => 'publish'
            @post_created = Post.find(assigns(:post).id)
            assert @post_created
            assert_equal('New Post', assigns(:post).title)
            assert_equal('Cool body', assigns(:post).body)
          end

          should_assign_to(:blog) { @blog }
          should_assign_to(:post) { Post.find(@post_created.id) }
          should_set_the_flash_to /created/i
          should_redirect_to('member conversatio blog posts') {member_conversatio_blog_posts_path(@blog)}
        end

        context "on POST to :create without correct data" do
          setup do
            post :create, :blog_id => @blog.id
          end

          should_set_the_flash_to /failed/i
          should_render_template :new
        end

        context "on PUT to :update with correct data" do
          setup do
            put :update, :blog_id => @blog.id, :id => @post.id, :post => { :title => 'Title Changed', :body => 'Body changed' }, :state => 'publish'
            @post_updated = Post.find(@post.id)
            assert @post_updated
            assert_equal('Title Changed', @post_updated.title)
            assert_equal('Body changed', @post_updated.body)
          end
          
          should_assign_to(:blog) { @blog }
          should_set_the_flash_to /updated/i
          should_redirect_to('member conversatio blog posts') {member_conversatio_blog_posts_path(@post.blog)}
        end

        context "on PUT to :update without correct data" do
          setup do
            put :update, :blog_id => @blog.id, :id => @post.id, :post => { :title => nil, :body => 'Body changed' }, :state => 'publish'
          end
          
          should_set_the_flash_to /failed/i
          should_render_template :edit
        end

        context "on DELETE to :destroy" do
          setup do
            delete :destroy, :blog_id => @blog.id, :id => @post.id
            assert_nil Post.find_by_id(assigns(:post).id)
          end

          should_assign_to(:blog) { @blog }
          should_assign_to(:post) { @post }
          should_set_the_flash_to /deleted/i
          should_redirect_to('member conversatio blog posts') {member_conversatio_blog_posts_path(@post.blog)}
        end
      end
    end
  end
end