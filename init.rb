require_plugin 'tog_core'
#require_plugin 'thinking-sphinx'

require "i18n" unless defined?(I18n)
Dir[File.dirname(__FILE__) + '/locale/**/*.yml'].each do |file|
  I18n.load_path << file
end

Tog::Interface.sections(:site).add "Blogs", "/blogs"

Tog::Interface.sections(:member).add "Blogs", "/member/conversatio/blogs"

Tog::Plugins.helpers Conversatio::PostsHelper
Tog::Plugins.helpers Conversatio::BlogsHelper

Tog::Search.sources << "Post"
Tog::Search.sources << "Blog"
