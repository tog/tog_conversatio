atom_feed(:url => formatted_conversatio_blog_posts_url(@blog, :atom)) do |feed|
  feed.title(@blog.title)
  feed.updated(@posts.first ? @posts.first.created_at : Time.now.utc)

  for post in @posts
    feed.entry(post, :url => conversatio_blog_post_url(post.blog, post)) do |entry|
      entry.title(post.title)
      entry.content(textilize(post.body), :type => 'html')

      entry.author do |author|
        author.name(post.user.name)
        author.email(post.user.email)
      end
    end
  end
end