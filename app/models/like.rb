class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_commit :update_post_likes

  private

  def update_post_likes
    counter = post.likes.count('id')
    post.update(likesCounter: counter)
  end
end
