require File.dirname(__FILE__) + '/../../../test_helper'


class Member::Conversatio::BlogsControllerTest < ActionController::TestCase

  def setup
    @member_user = Factory(:user, :login => 'member_user', :admin => true)
    @blog = Factory(:blog, :title => 'My Blog', :description => 'Cool description', :author => @member_user)
    @bloggership = Factory(:bloggership, :user => @member_user, :blog => @blog)

    @controller = Member::Conversatio::BlogsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.session[:user_id] = @member_user.id
  end

# Deprecated should_be_restful
#  should_be_restful do |resource|
#    resource.formats       = [:html]

#    resource.actions       = [:index, :new, :edit, :update, :create, :destroy]

#    resource.create.params = { :title => "My Blog", :description => 'Cool description'}
#    resource.update.params = { :title => "Correct name" }

#    resource.create.redirect  = "conversatio_blog_path(@blog)"
#    resource.update.redirect  = "conversatio_blog_path(@blog)"
#    resource.destroy.redirect = "member_conversatio_blogs_url"

#    resource.create.flash  = /create/i
#    resource.update.flash  = /update/i
#    resource.destroy.flash = /delete/i
#  end
end