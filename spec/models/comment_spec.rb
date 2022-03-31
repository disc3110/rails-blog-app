require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    user = User.find(1)
    post = Post.find(1)
    @comment = Comment.new(author: user, post: post, text: 'Hello, how are you?')
  end

  it 'comment with correct parameters should be valid' do
    expect(@comment).to be_valid
  end
end
