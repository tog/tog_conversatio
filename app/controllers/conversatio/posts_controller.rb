class Conversatio::PostsController < ApplicationController

  helper 'conversatio/blogs'
  
  def index
    redirect_to conversatio_blog_path Blog.find params[:blog_id]
  end

  def show
    @blog = Blog.find params[:blog_id]
    @post = @blog.posts.published.select{|i| i==Post.find(params[:id])}.first
  end

  def by_tag
    @blog = Blog.find params[:blog_id]
    @tag  = Tag.find_by_name(params[:tag_name])
    if !@tag.nil?
      @order = params[:order] || 'title'
      @page = params[:page] || '1'
      @asc = params[:asc] || 'asc'
      @posts = Post.published.find_tagged_with(@tag,
                    :conditions => ['posts.blog_id=?', @blog]
                    ).paginate :per_page => 10,
                               :page => @page,
                               :order => @order + " " + @asc
    end
  end

  def all_by_tag
    @tag  =  Tag.find_by_name(params[:tag_name])
    @posts = Post.published.find_tagged_with(@tag) unless @tag.nil?
  end

  def archives
    @page  = params[:page] || '1'
    @year  = params[:year]
    @month = params[:month]
    @day   = params[:day]

    from = DateTime.strptime("#{@year}/#{@month||01}/#{@day||01}", "%Y/%m/%d")
    to   = DateTime.strptime("#{@year}/#{@month||12}/#{@day||01} 23:59:59", "%Y/%m/%d %H:%M:%S")
    to   = DateTime.new(to.year, to.month, -1, 23, 59, 59) if @day.nil?

    @blog = Blog.find params[:blog_id]
    @posts = @blog.posts.published.paginate :per_page => 10,
                                           :page => @page,
                                           :conditions => ['published_at between ? and ?', from, to],
                                           :order => "published_at desc"
  end

end
