require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    user = User.find(1)
    post = Post.find(1)
    @like = Like.new(author: user, post: post)
  end

  it 'like should be valid' do
    @like.save
    expect(@like).to be_valid
  end
end
