class Member::Conversatio::BloggershipsController < Member::BaseController

  before_filter :find_blog

  def index
    @bloggerships = @blog.bloggerships.paginate :per_page => Tog::Config['plugins.tog_core.pagination_size'], :page => params[:page]
  end

  def create
    u = User.find(params[:bloggership][:user_id])
    if current_user.profile.is_related_to?(u.profile)
      @bloggership = u.bloggerships.create(:blog => @blog)
      flash[:ok]='Editor added successfully.'
    else
      flash[:error]='The user selected should be related with you.'
    end
    redirect_to member_conversatio_blog_bloggerships_path(@blog)
  end

  def destroy
    @bloggership = @blog.bloggerships.destroy(params[:id])

    flash[:ok]='Editor deleted.'
    redirect_to member_conversatio_blog_bloggerships_path(@blog)
  end

  private

    def find_blog
      @blog = Blog.find(params[:blog_id])
      unless @blog.author == current_user
        flash[:error]="Only blog's author can do this"
        redirect_back_or_default(member_conversatio_blogs_path)
      end
    end
end