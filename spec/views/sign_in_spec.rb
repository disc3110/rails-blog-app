require 'rails_helper'

RSpec.describe 'Sign In', type: :feature do
  before :each do
    @user = User.new(name: 'Diego', photo: 'http://photo.com', bio: 'Hello rails', postsCounter: 5,
                     email: 'rspec@gmail.com', password: '123456')
    @user.skip_confirmation!
    @user.save!
    visit new_user_session_path
  end

  it 'I can see the input in login page' do
    expect(page).to have_field 'Email'
    expect(page).to have_field 'Password'
    expect(page).to have_button 'Log in'
  end

  it 'empty email or password' do
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    click_button 'Log in'
    expect(page).to have_content 'Invalid'
  end

  it 'wrong email or password' do
    fill_in 'Email', with: 'test@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content 'Invalid'
  end

  it 'vaild email and password' do
    fill_in 'Email', with: 'rspec@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_current_path root_path
  end
end
