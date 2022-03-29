class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def update_author_posts
    counter = author.posts.count('id')
    author.update(posts_counter: counter)
  end

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
