require 'rails_helper'

RSpec.describe "User Show", type: :feature do
  before :each do
    @user = User.new(name: 'Diego', photo: 'http://photo.com', bio: 'Hello rails', postsCounter: 5, email: 'rspec@gmail.com', password: '123456')
    @user.skip_confirmation!
    @user.save!
    @user.posts.create(title: 'New Post 1', text: 'This is a new text', commentsCounter: 5, likesCounter: 5)
    @user.posts.create(title: 'New Post 2', text: 'This is a new text', commentsCounter: 5, likesCounter: 5)
    @post = @user.posts.create(title: 'New Post 3', text: 'This is a new text', commentsCounter: 5, likesCounter: 5)
    @user.posts.create(title: 'New Post 4', text: 'This is a new text', commentsCounter: 5, likesCounter: 5)
    @user.posts.create(title: 'New Post 5', text: 'This is a new text', commentsCounter: 5, likesCounter: 5)
    visit new_user_session_path
    fill_in 'Email', with: 'rspec@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    visit user_path(@user)
  end

  it 'show user information' do
    expect(page).to have_selector('img', count: 1)
    expect(page).to have_content('Diego')
    expect(page).to have_content('Number of posts: 5')
    expect(page).to have_content('Hello rails')
    expect(page).to have_selector('.post-box', count: 3)
    expect(page).to have_content('See all posts')
    # click_on 'Robert'
    # expect(page).to have_current_path user_path(@user)
  end

  it "it redirects to that post's show page" do
    click_on 'New Post 3'
    expect(page).to have_current_path user_post_path(@user, @post)
  end

  it "it redirects me to the user's post's index page" do
    click_on 'See all posts'
    expect(page).to have_current_path user_posts_path(@user)
  end
end