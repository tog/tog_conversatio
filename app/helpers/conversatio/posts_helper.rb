module Conversatio
  module PostsHelper

    def select_post_state_tag(post)
      default_state = !post.new_record? && post.aasm_current_state == :published ? "publish" : "draft"
      options = [[ I18n.t('tog_conversatio.model.states.draft'), "draft" ], [ I18n.t('tog_conversatio.model.states.published'), "publish" ]]
      select_tag("state", options_for_select(options.uniq, default_state))
    end
    
  end
end
