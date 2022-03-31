class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_post_comments

  validates :text, presence: true, length: { maximum: 250 }

  def three_recent_posts
    posts.order(created_at: :desc).limit(quantity)
  end

  private

  def update_post_comments
    counter = post.comments.count('id')
    post.update(commentsCounter: counter)
  end
end
