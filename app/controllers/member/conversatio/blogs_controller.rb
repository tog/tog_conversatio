class Member::Conversatio::BlogsController < Member::BaseController

  helper 'conversatio/blogs'

  def index
    @order = params[:order] || 'title'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'asc'
    @blogs = current_user.blogs.paginate :per_page => Tog::Config['plugins.tog_core.pagination_size'],
                                         :page => @page,
                                         :order => @order + " " + @asc
  end

  def edit
    @blog = current_user.blogs.find(params[:id])
  end

  def new
    @blog = current_user.blogs.new
  end

  def create
    bs = current_user.bloggerships.new
    @blog = bs.build_blog params[:blog]
    @blog.author = current_user

    respond_to do |wants|
      if bs.save
        wants.html do
          flash[:ok] = I18n.t('tog_conversatio.member.blogs.blog_created')
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
          flash[:ok]=I18n.t('tog_conversatio.member.blogs.blog_updated')
          redirect_to conversatio_blog_path(@blog)
        end
      else
        wants.html do
          flash.now[:error]='Failed to update the blog.'
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
        flash[:ok]=I18n.t('tog_conversatio.member.blogs.blog_removed')
        redirect_to member_conversatio_blogs_path
      end
    end
  end

end
