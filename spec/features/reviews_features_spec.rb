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
    fill_in 'Name', with: name
    fill_in 'Description', with: description
    click_button 'create project'
  end

  def leave_review (thoughts, rating)
    visit '/projects'
    click_link 'review Crowdfundingtestproject'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'leave review'
  end

feature 'reviewing:' do  
  before do
    user = create :admin1 
    login_user('admin1@example.com', 'password678')
    add_project('Crowdfundingtestproject', 'this is the description')
    click_link 'log out'
    user = create :user1 
    login_user('user1@example.com', 'password123')
  end

  scenario 'allows users to leave a review using a form' do
    leave_review('seems fairly good', '3')
    expect(current_path).to eq '/projects'
    expect(page).to have_content('seems fairly good')
    expect(page).to have_content("you've successfully left a review!")
  end

  scenario 'allows user to see review and rating on the show page' do
    leave_review('seems fairly good', '3')
    click_link 'Crowdfundingtestproject'
    expect(page).to have_content('seems fairly good')
    expect(page).to have_content('★★★')
  end

  scenario 'displays user email to identify author of review' do
    leave_review('seems fairly good', '3')
    click_link 'Crowdfundingtestproject'
    expect(page).to have_content('review by user1@example.com')
  end

  scenario 'displays an average rating for all reviews' do
    leave_review('so so', '3')
    click_link 'log out'
    user = create :user2
    login_user('user2@example.com', 'password246')
    leave_review('great', '5')
    expect(page).to have_content('average rating: ★★★★☆')
  end

  # scenario 'user has to be logged in to leave a review' do
  #   click_link 'log out'
  #   visit '/projects'
  #   click_link 'review Crowdfundingtestproject'
  #   expect(page).to have_content('you need to be logged in to leave a review.')
  # end

  scenario 'user cannot leave multiple reviews' do
    leave_review('a bit awful', '1')
    click_link 'review Crowdfundingtestproject'
    expect(page).to have_content('you cannot review the same project twice.')
  end

context 'deleting reviews:' do
  before do
      leave_review('awful', '1')
      click_link 'Crowdfundingtestproject'
  end  

    it 'users can delete their own reviews' do
      click_link 'delete review'
      expect(page).not_to have_content('awful')
      expect(page).to have_content('Review deleted successfully')
    end

    it "users cannot delete another user's review" do
      click_link 'log out'
      user = create :user2 
      login_user('user2@example.com', 'password246')
      visit '/projects'
      click_link 'Crowdfundingtestproject'
      click_link 'delete review'
      expect(page).to have_content("you cannot delete somebody else's review!")
    end

  end
end