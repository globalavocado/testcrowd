require 'rails_helper'

  def signup_user (email, password)
    visit '/' 
    click_link 'sign up' 
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up' 
  end

feature 'reviewing:' do  
    before do
      signup_user('test@example.com', 'password123')
      click_link 'add a project'
      fill_in 'Name', with: 'Crowdfundingtestproject'
      click_button 'create project'
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
    expect(page).to have_content('review by test@example.com')
  end

  scenario 'user has to be logged in to leave a review' do
    click_link 'log out'
    visit '/projects'
    click_link 'review Crowdfundingtestproject'
    expect(page).to have_content('you need to be logged in to leave a review.')
  end

  scenario 'user cannot leave multiple reviews' do
    visit '/projects'
    click_link 'review Crowdfundingtestproject'
    fill_in 'Thoughts', with: 'awful'
    select '1', from: 'Rating'
    click_button 'leave review'
    click_link 'review Crowdfundingtestproject'
    expect(page).to have_content('you cannot review the same project twice.')
  end

  scenario 'users can delete reviews' do
    visit '/projects'
    click_link 'review Crowdfundingtestproject'
    fill_in 'Thoughts', with: 'awful'
    select '1', from: 'Rating'
    click_button 'leave review'
    click_link 'Crowdfundingtestproject'
    click_link 'delete review'
    expect(page).not_to have_content 'awful'
    expect(page).to have_content('Review deleted successfully')
  end

end