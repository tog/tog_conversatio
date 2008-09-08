class Conversatio::BlogsController < ApplicationController

  def index
    @order = params[:order] || 'title'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'asc'
    @blogs = Conversatio::Blog.paginate :per_page => 10,
                                        :page => @page,
                                        :order => @order + " " + @asc
  end

  def show
    @page = params[:page] || '1'

    @blog = Conversatio::Blog.find params[:id]
    @posts = @blog.published_posts.paginate :per_page => 10,
                                            :page => @page, 
                                            :order => "created_at desc"

    respond_to do |format|
      format.html
      format.atom { render(:layout => false) }
    end
  end

end