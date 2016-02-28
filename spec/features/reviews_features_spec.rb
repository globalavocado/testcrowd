require 'rails_helper'

  def leave_review(thoughts, rating)
    visit '/projects'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'leave review'
  end

feature 'reviewing' do
  
  before {Project.create name: 'Crowdfundingtestproject'}

  scenario 'allows users to leave a review using a form' do
    visit '/projects'
    click_link 'review Crowdfundingtestproject'
    fill_in 'Thoughts', with: 'seems fairly good'
    select '3', from: 'Rating'
    click_button 'leave review'

    expect(current_path).to eq '/projects'
    expect(page).to have_content('seems fairly good')
  end

    # context 'user signed in on the home page' do
    #   before do
    #     user1 = User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
    #     user2 = User.create(email: 'test2@example.com', password: 'password678', password_confirmation: 'password678')
    #     login_as(user1)
    #     leave_review('awful', 1)
    #     leave_review('almost amazing', 4)

    #     click_link('sign in')
    #     fill_in('Email', with: 'test@example.com')
    #     fill_in('Password', with: 'password123')
    #     fill_in('Password confirmation', with: 'password123')
    #     click_button('Sign in')
    #   end


    # end
end