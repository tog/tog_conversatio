class Member::Conversatio::PostsController < Member::BaseController
  before_filter :load_blog
  
  helper 'conversatio/blogs'
  

  def index
    @order = params[:order] || 'title'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'asc'    
    @posts = @blog.posts.paginate :per_page => 10,
                                  :page => @page,
                                  :order => @order + " " + @asc    
  end

  def show
    @post = @blog.posts.find params[:id]
    @comments = @post.comments
  end

  def edit
    @post = @blog.posts.find params[:id]
  end

  def new
  end

  def create
    @post = Conversatio::Post.new params[:post]
    @post.blog = @blog
    @post.user = current_user

    respond_to do |wants|
      if @post.save
        @post.send("#{params[:state].to_s}!")
        wants.html do
          flash[:ok] = 'New blog created.'
          redirect_to member_conversatio_blog_posts_path(@blog)
        end
      else
        wants.html do
          flash.now[:error] = 'Failed to create a new blog.'
          render :action => :new
        end
      end
    end
  end

  def update
    @post = @blog.posts.find params[:id]

    respond_to do |wants|
      if @post.update_attributes(params[:post])
        @post.send("#{params[:state].to_s}!")
        wants.html do
          flash[:ok]='Blog post updated.'
          redirect_to member_conversatio_blog_posts_path(@post.blog)
        end
      else
        wants.html do
          flash.now[:error]='Failed to update the blog post.'
          render :action => :edit
        end
      end
    end
  end

  def destroy
    @post = @blog.posts.find params[:id]
    @post.destroy
    
    respond_to do |wants|
      wants.html do
        flash[:ok]='Blog post deleted.'
        redirect_to member_conversatio_blog_posts_path(@post.blog)
      end
    end
  end

private
  def load_blog
    @blog  = current_user.blogs.find params[:blog_id]
  end
end
