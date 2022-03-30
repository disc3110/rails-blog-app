class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_author_posts

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_author_posts
    counter = author.posts.count('id')
    author.update(postsCounter: counter)
  end
end
