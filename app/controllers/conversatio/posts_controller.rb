class Conversatio::PostsController < ApplicationController

  helper 'conversatio/blogs'

  def show
    @blog = Conversatio::Blog.find params[:blog_id]
    @post = @blog.published_posts.find params[:id]
  end

  def by_tag
    @blog = Conversatio::Blog.find params[:blog_id]
    @tag  =  Tag.find_by_name(params[:tag_name])
    if !@tag.nil?
      @order = params[:order] || 'title'
      @page = params[:page] || '1'
      @asc = params[:asc] || 'asc'      
      @posts = Conversatio::Post.find_tagged_with(@tag, 
                    :conditions => ['posts.blog_id=? and posts.state=?', @blog, "published"]
                    ).paginate :per_page => 10,
                               :page => @page,
                               :order => @order + " " + @asc   
    end                 
  end

  def all_by_tag
    @tag  =  Tag.find_by_name(params[:tag_name])
    @posts = Conversatio::Post.find_tagged_with(@tag, :conditions => ['posts.state=?', "published"]) unless @tag.nil?
  end

  def archives
    @page  = params[:page] || '1'
    @year  = params[:year]
    @month = params[:month]
    @day   = params[:day]
    
    from = DateTime.strptime("#{@year}/#{@month||01}/#{@day||01}", "%Y/%m/%d")
    to   = DateTime.strptime("#{@year}/#{@month||12}/#{@day||01} 23:59:59", "%Y/%m/%d %H:%M:%S")
    to   = DateTime.new(to.year, to.month, -1, 23, 59, 59) if @day.nil?
    
    @blog = Conversatio::Blog.find params[:blog_id]
    @posts = @blog.published_posts.paginate :per_page => 10,
                                            :page => @page,
                                            :conditions => ['created_at between ? and ?', from, to],
                                            :order => "created_at desc"
  end

end
