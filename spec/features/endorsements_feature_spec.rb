require 'rails_helper'

def login_user (email, password)
    visit '/' 
    click_link 'log in' 
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in' 
end

def add_project (name, description)
  visit '/projects'
  click_link 'add a project'
  fill_in 'Name', with: 'Crowdfundingtestproject'
  fill_in 'Description', with: 'this is the description'
  click_button 'create project'
end

def leave_review (thoughts, rating)
  visit '/projects'
  click_link 'review Crowdfundingtestproject'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'leave review'
end

feature 'endorsing reviews' do
  before do
    user = create :admin1 
    login_user('admin1@example.com', 'password678')
    add_project('Crowdfundingtestproject', 'this is the description')
    click_link 'log out'
    user = create :user1 
    login_user('user1@example.com', 'password123')
    leave_review('seems fairly good', '3')
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    visit '/projects'
    click_link 'Crowdfundingtestproject'
    click_link 'endorse review'
    expect(page).to have_content('1 endorsement')
  end

end