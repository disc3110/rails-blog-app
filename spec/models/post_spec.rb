require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    user = User.find(1)
    @post = Post.new(title: 'New Post', text: 'This is a new text', author: user, commentsCounter: 5, likesCounter: 5)
  end

  it 'should be valid with the correct parameters' do
    expect(@post).to be_valid
  end

  it 'name must be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'commentsCounter must be an integer' do
    @post.commentsCounter = 1.5
    expect(@post).to_not be_valid
  end

  it 'commentsCounter must be greater than 0' do
    @post.commentsCounter = -3
    expect(@post).to_not be_valid
  end

  it 'likesCounter must be an integer' do
    @post.likesCounter = 1.5
    expect(@post).to_not be_valid
  end

  it 'likesCounter must be greater than 0' do
    @post.likesCounter = -3
    expect(@post).to_not be_valid
  end

  describe '#five_recent_comments' do
    it 'returns an array with the last five recent comments' do
      @post.save!
      comment1 = @post.comments.create!(author_id: 1, text: 'Hello rails')
      comment2 = @post.comments.create!(author_id: 1, text: 'Hello rails')
      comment3 = @post.comments.create!(author_id: 1, text: 'Hello rails')
      comment4 = @post.comments.create!(author_id: 1, text: 'Hello rails')
      comment5 = @post.comments.create!(author_id: 1, text: 'Hello rails')
      comments = [comment1, comment2, comment3, comment4, comment5]
      expect(@post.five_recent_comments).to match_array(comments)
    end
  end
end
