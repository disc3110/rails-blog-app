require 'rails_helper'

RSpec.describe 'RESTful API', type: :request do
  before do
    @user = User.new(name: 'Diego', photo: 'http://photo.com', bio: 'Hello rails', postsCounter: 5,
                     email: 'rspec@gmail.com', password: '123456')
    @user.skip_confirmation!
    @user.save!
    @post = @user.posts.create(title: 'New Post 3', text: 'This is a new text', commentsCounter: 5, likesCounter: 5)
    @comment = @post.comments.create(author: @user, text: 'Hello, how are you?')
  end
  let(:user_id) { @user.id }
  # Test suite for GET /todos/:id
  describe 'endpoint to list all posts for a user' do
    before do
      get "/users/#{user_id}/posts", params: {}, headers:, as: :json
    end

    context 'when the user exists' do
      it 'returns the posts of the user' do
        expect(json).not_to be_empty
        expect(json[0]['author_id']).to eq(@user.id)
        expect(json.length).to eq 1
      end
      it 'returns status code 200' do
        expect(response).to have_http_status(:ok)
      end
    end
    context 'when the user does not exist' do
      let(:user_id) { 100 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end
end
