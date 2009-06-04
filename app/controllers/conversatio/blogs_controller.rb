class Conversatio::BlogsController < ApplicationController

  def index
    @order = params[:order] || 'title'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'asc'
    @blogs = Blog.paginate :per_page => 10,
                           :page => @page,
                           :order => @order + " " + @asc
  end

  def show
    @page = params[:page] || '1'

    @blog = Blog.find params[:id]
    @posts = @blog.posts.published.paginate :per_page => 10,
                                           :page => @page, 
                                           :order => "published_at desc"

    respond_to do |format|
      format.html
      format.atom { render(:layout => false) }
    end
  end

end