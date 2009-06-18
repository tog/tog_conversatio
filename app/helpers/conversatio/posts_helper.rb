module Conversatio
  module PostsHelper

    def select_post_state_tag(post)
      default_state = !post.new_record? && post.current_state == :published ? "publish" : "draft"
      options = [[ "draft", "draft" ], [ "published", "publish" ]]
      select_tag("state", options_for_select(options.uniq, default_state))
    end
    
  end
end
