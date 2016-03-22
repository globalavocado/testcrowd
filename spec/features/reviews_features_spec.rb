require 'rails_helper'

  # def signup_user (email, password)
  #   visit '/' 
  #   click_link 'sign up' 
  #   fill_in 'Email', with: email
  #   fill_in 'Password', with: password
  #   fill_in 'Password confirmation', with: password
  #   click_button 'Sign up' 
  # end

feature 'reviewing:' do  
  before do
    user = create :admin1 
    visit '/'
    click_link 'log in'
    fill_in 'Email', with: 'admin1@example.com'
    fill_in 'Password', with: 'password678'
    click_button 'Log in'
    click_link 'add a project'
    fill_in 'Name', with: 'Crowdfundingtestproject'
    fill_in 'Description', with: 'this is the description'
    click_button 'create project'
    click_link 'log out'
    user = create :user1 
    visit '/'
    click_link 'log in'
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password123'
    click_button 'Log in'
  end

  scenario 'allows users to leave a review using a form' do
    visit '/projects'
    click_link 'review Crowdfundingtestproject'
    fill_in 'Thoughts', with: 'seems fairly good'
    select '3', from: 'Rating'
    click_button 'leave review'
    expect(current_path).to eq '/projects'
    expect(page).to have_content('seems fairly good')
  end

  scenario 'allows user to see review and rating on the show page' do
    visit '/projects'
    click_link 'review Crowdfundingtestproject'
    fill_in 'Thoughts', with: 'seems fairly good'
    select '3', from: 'Rating'
    click_button 'leave review'
    click_link 'Crowdfundingtestproject'
    expect(page).to have_content('seems fairly good')
    expect(page).to have_content('3')
  end

  scenario 'displays user email to identify author of review' do
    visit '/projects'
    click_link 'review Crowdfundingtestproject'
    fill_in 'Thoughts', with: 'seems fairly good'
    select '3', from: 'Rating'
    click_button 'leave review'
    click_link 'Crowdfundingtestproject'
    expect(page).to have_content('review by user1@example.com')
  end

  # scenario 'user has to be logged in to leave a review' do
  #   click_link 'log out'
  #   visit '/projects'
  #   click_link 'review Crowdfundingtestproject'
  #   expect(page).to have_content('you need to be logged in to leave a review.')
  # end

  scenario 'user cannot leave multiple reviews' do
    visit '/projects'
    click_link 'review Crowdfundingtestproject'
    fill_in 'Thoughts', with: 'awful'
    select '1', from: 'Rating'
    click_button 'leave review'
    click_link 'review Crowdfundingtestproject'
    expect(page).to have_content('you cannot review the same project twice.')
  end

context 'deleting reviews:' do
  before do
      visit '/projects'
      click_link 'review Crowdfundingtestproject'
      fill_in 'Thoughts', with: 'awful'
      select '1', from: 'Rating'
      click_button 'leave review'
      click_link 'Crowdfundingtestproject'
  end  

    it 'users can delete their own reviews' do
      click_link 'delete review'
      expect(page).not_to have_content 'awful'
      expect(page).to have_content('Review deleted successfully')
    end

    it "users cannot delete another user's review" do
      click_link 'log out'
      user = create :user2 
      visit '/'
      click_link 'log in'
      fill_in 'Email', with: 'user2@example.com'
      fill_in 'Password', with: 'password246'
      click_button 'Log in'
      visit '/projects'
      click_link 'Crowdfundingtestproject'
      click_link 'delete review'
      expect(page).to have_content("you cannot delete somebody else's review!")
    end

  end
end