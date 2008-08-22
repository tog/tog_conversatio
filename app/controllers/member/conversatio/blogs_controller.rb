class Member::Conversatio::BlogsController < Member::BaseController

  layout "member"
  
  def index
    @blogs = current_user.blogs
  end

  def show
    @blog = current_user.blogs.find(params[:id])
  end

  def edit
    @blog = current_user.blogs.find(params[:id])
  end

  def new
  end

  def create
    bs = current_user.bloggerships.new
    @blog = bs.build_blog params[:blog]
    @blog.author = current_user

    respond_to do |wants|
      if bs.save
        wants.html do
          flash[:notice] = 'New blog created.'
          redirect_to conversatio_blog_path(@blog)
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
    @blog = current_user.blogs.find(params[:id])
    
    respond_to do |wants|
      if @blog.update_attributes(params[:blog])
        wants.html do
          flash[:notice]='Blog post updated.'
          redirect_to conversatio_blog_path(@blog)
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
    @blog = current_user.blogs.find(params[:id])
    
    @blog.destroy
    respond_to do |wants|
      wants.html do
        flash[:notice]='Blog post deleted.'
        redirect_to admin_conversatio_blogs_path
      end
    end
  end

end
