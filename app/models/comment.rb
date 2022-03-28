class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def three_recent_posts
    posts.order(created_at: :desc).limit(quantity)
  end

  def update_post_comments
    counter = post.comments.count('id')
    post.update(comments_counter: counter)
  end
end
