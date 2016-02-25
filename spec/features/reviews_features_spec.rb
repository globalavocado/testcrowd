require 'rails_helper'

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
end