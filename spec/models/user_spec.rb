require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.new(name: 'Diego', photo: 'http://photo.com', bio: 'Hello rails', postsCounter: 5,
                     email: 'rspec@gmail.com', password: '123456')
  end

  it 'name should be valid with correct parameters' do
    expect(@user).to be_valid
  end

  it 'name should be present' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'postCounter should be an integer' do
    @user.postsCounter = 5.5
    expect(@user).to_not be_valid
  end

  it 'postCounter should be greater than or equal to 0' do
    @user.postsCounter = -1
    expect(@user).to_not be_valid
  end

  describe '#three_recent_post' do
    it 'returns the last 3 posts' do
      @user.skip_confirmation!
      @user.save!

      post1 = Post.create!(title: 'New Post 1', text: 'This is a new text', author_id: @user.id, commentsCounter: 5,
                           likesCounter: 5)
      post2 = Post.create!(title: 'New Post 2', text: 'This is a new text', author_id: @user.id, commentsCounter: 5,
                           likesCounter: 5)
      post3 = Post.create!(title: 'New Post 3', text: 'This is a new text', author_id: @user.id, commentsCounter: 5,
                           likesCounter: 5)

      posts = [post1, post2, post3]
      expect(@user.three_recent_posts).to match_array(posts)
    end
  end
end
