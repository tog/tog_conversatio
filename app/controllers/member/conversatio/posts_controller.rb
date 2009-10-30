class Member::Conversatio::PostsController < Member::BaseController
  before_filter :load_blog

  helper 'conversatio/blogs'

  def index
    @order = params[:order] || 'created_at'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'desc'
    @posts = @blog.posts.paginate :per_page => Tog::Config['plugins.tog_core.pagination_size'],
                                  :page => @page,
                                  :order => @order + " " + @asc
  end

  def show
    @post = @blog.posts.find params[:id]
    @comments = @post.all_comments
  end

  def new
    @post = @blog.posts.new(:state => :draft)
  end

  def edit
    @post = @blog.posts.find params[:id]
  end

  def create
    @post = Post.new params[:post]
    @post.blog = @blog
    @post.user = current_user
    @post.published_at = nil unless params[:update_published_at]

    respond_to do |wants|
      if @post.save
        @post.send("#{params[:state].to_s}!") if @post.aasm_events_for_current_state.map{|e| e.to_s}.include?("#{params[:state]}")
        wants.html do
          flash[:ok] = I18n.t('tog_conversatio.member.posts.post_created')
          redirect_to member_conversatio_blog_posts_path(@blog)
        end
      else
        wants.html do
          flash.now[:error] = 'Failed to create a new post.'
          render :action => :new
        end
      end
    end
  end

  def update
    @post = @blog.posts.find params[:id]
    
    respond_to do |wants|
      if @post.update_attributes(params[:post])
        @post.update_attribute(:published_at, nil) unless params[:update_published_at]
        @post.send("#{params[:state].to_s}!") if @post.aasm_events_for_current_state.map{|e| e.to_s}.include?("#{params[:state]}")
        wants.html do
          flash[:ok]=I18n.t('tog_conversatio.member.posts.post_updated')
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
        flash[:ok]=I18n.t('tog_conversatio.member.posts.post_removed')
        redirect_to member_conversatio_blog_posts_path(@post.blog)
      end
    end
  end

private
  def load_blog
    @blog  = current_user.blogs.find params[:blog_id]
  end
end
