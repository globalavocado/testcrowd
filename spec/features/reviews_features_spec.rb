require 'rails_helper'

  # def leave_review(thoughts, rating)
  #   fill_in 'Thoughts', with: thoughts
  #   select rating, from: 'Rating'
  #   click_button 'leave review'
  # end

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

  scenario 'user cannot leave multiple reviews' do
    visit '/projects'
    click_link 'review Crowdfundingtestproject'
    fill_in 'Thoughts', with: 'awful'
    select '1', from: 'Rating'
    click_button 'leave review'
    click_link 'review Crowdfundingtestproject'
    expect(page).to have_content('you cannot review the same project twice.')
  end

end