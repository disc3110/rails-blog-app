class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :commentsCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likesCounter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_author_posts
  after_destroy :update_author_posts

  def five_recent_comments
    comments.order(created_at: :desc).limit(5).includes(:author)
  end

  private

  def update_author_posts
    counter = author.posts.count('id')
    author.update(postsCounter: counter)
  end
end
