class Member::Conversatio::BloggershipsController < Member::BaseController

  before_filter :find_blog

  def index
    @bloggerships = @blog.bloggerships.paginate :per_page => Tog::Config['plugins.tog_core.pagination_size'], :page => params[:page]
  end

  def create
    u = User.find(params[:bloggership][:user_id])
    if current_user.profile.is_related_to?(u.profile)
      @bloggership = u.bloggerships.create(:blog => @blog)
      flash[:ok]= I18n.t("tog_conversatio.member.bloggerships.editor_added")
    else
      flash[:error]=I18n.t("tog_conversatio.member.bloggerships.user_not_related")
    end
    redirect_to member_conversatio_blog_bloggerships_path(@blog)
  end

  def destroy
    @bloggership = @blog.bloggerships.find(params[:id]).destroy

    flash[:ok]=I18n.t("tog_conversatio.member.bloggerships.editor_deleted")
    redirect_to member_conversatio_blog_bloggerships_path(@blog)
  end

  private

    def find_blog
      @blog = Blog.find(params[:blog_id])
      unless @blog.author == current_user
        flash[:error]=I18n.t("tog_conversatio.member.bloggerships.author_only")
        redirect_back_or_default(member_conversatio_blogs_path)
      end
    end
end
