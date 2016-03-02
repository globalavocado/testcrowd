require 'rails_helper'

  def signup_user (email, password)
    visit '/' 
    click_link 'sign up' 
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up' 
  end

feature 'reviewing' do  
    before do
      signup_user('test@example.com', 'password123')
      click_link 'add a project'
      fill_in 'Name', with: 'Crowdfundingtestproject'
      click_button 'create project'
      # expect(page).to have_content 'Crowdfundingtestproject'
      # expect(current_path).to eq '/projects'
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

  scenario 'user cannot leave multiple reviews' do
    visit '/projects'
    click_link 'review Crowdfundingtestproject'
    fill_in 'Thoughts', with: 'awful'
    select '1', from: 'Rating'
    click_button 'leave review'
    click_link 'review Crowdfundingtestproject'
    fill_in 'Thoughts', with: 'awful'
    click_button 'leave review'
    expect(page).to have_content('you cannot review the same project twice.')
  end

end