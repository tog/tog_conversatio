module Conversatio
  module BlogsHelper

    def last_posts(blog, limit=5)
      size = blog.published_posts.size
      if size > 0 and size < limit
        posts = blog.published_posts[0..size - 1]
      elsif size > 0
        posts = blog.published_posts[0..limit - 1]
      else
        posts = blog.published_posts  
      end
      posts
    end

    def archives_menu
      html = "<ul>"
      publication_years = @blog.created_at.year .. Time.now.year
      for year in publication_years
        html << "<li>#{link_to("#{year}", yearly_archives_conversatio_blog_posts_path(@blog, year))}</li>"
        if @year
          html << "<ul>"
          for m in 1..12
            html << "<li>#{link_to(Date::ABBR_MONTHNAMES[m], monthly_archives_conversatio_blog_posts_path(@blog, year, m))}</li>"
          end
          html << "</ul>"
        end
      end
      html << "</ul>"
    end

    def tag_cloud_posts(classes)
      return if !@blog
      tags = @blog.posts.tag_counts(:conditions => ["posts.state='published'"])
      return if tags.empty?
      max_count = tags.sort_by(&:count).last.count.to_f
      tags.each do |tag|
        index = ((tag.count / max_count) * (classes.size - 1)).round
        yield tag, classes[index]
      end
    end

    def tag_cloud_blogs(classes)
      tags = Conversatio::Post.tag_counts(:conditions => ["posts.state='published'"])
      return if tags.empty?
      max_count = tags.sort_by(&:count).last.count.to_f
      tags.each do |tag|
        index = ((tag.count / max_count) * (classes.size - 1)).round
        yield tag, classes[index]
      end
    end

  end
end
