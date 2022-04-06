require 'rails_helper'

RSpec.describe 'Post index', type: :feature do
  before :each do
    @user = User.new(name: 'Diego', photo: 'http://photo.com', bio: 'Hello rails', postsCounter: 5,
                     email: 'rspec@gmail.com', password: '123456')
    @user.skip_confirmation!
    @user.save!
    @post = @user.posts.create(title: 'New Post 3', text: 'This is a new text', commentsCounter: 5, likesCounter: 5)
    @comment = @post.comments.create(author: @user, text: 'Hello, how are you?')
    visit new_user_session_path
    fill_in 'Email', with: 'rspec@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    visit user_posts_path(@user)
  end

  it 'show post information' do
    expect(page).to have_selector('img', count: 1)
    expect(page).to have_content('Diego')
    expect(page).to have_content('Number of posts: 1')
    expect(page).to have_content('New Post 3')
    expect(page).to have_content('This is a new text')
    expect(page).to have_selector('.comment-box', count: 1)
    expect(page).to have_content('Comments: 1')
    expect(page).to have_content('Likes:5')
    expect(page).to have_selector('.pagination', count: 1)
  end

  it "it redirects to that post's show page" do
    click_on 'New Post 3'
    expect(page).to have_current_path user_post_path(@user, @post)
  end
end
