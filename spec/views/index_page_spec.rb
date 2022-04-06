require 'rails_helper'

RSpec.describe 'User Index', type: :feature do
  before :each do
    @user = User.new(name: 'Diego', photo: 'http://photo.com', bio: 'Hello rails', postsCounter: 5,
                     email: 'rspec@gmail.com', password: '123456')
    @user.skip_confirmation!
    @user.save!
    @user = User.new(name: 'Robert', photo: 'http://photo.com', bio: 'Hello rails', postsCounter: 5,
                     email: 'robert@gmail.com', password: '123456')
    @user.skip_confirmation!
    @user.save!
    visit new_user_session_path
    fill_in 'Email', with: 'rspec@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    visit root_path
  end

  it 'show other users information' do
    expect(page).to have_content('Robert')
    expect(page).to have_selector('img', count: 5)
    expect(page).to have_content('Number of posts:')
    click_on 'Robert'
    expect(page).to have_current_path user_path(@user)
  end
end
