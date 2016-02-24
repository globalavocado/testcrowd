require 'rails_helper'

feature 'projects:' do
	context 'no projects have been added' do
		scenario 'should display a prompt to add a project' do
		  visit '/projects'
		  expect(page).to have_content 'no projects yet!'
		  expect(page).to have_link 'add a project'
		end
	end

	context 'projects have been added:' do
	  before do
	    Project.create(name: 'Crowdfundingtestproject')
	  end

	  scenario 'display projects' do
	    visit '/projects'
	    expect(page).to have_content('Crowdfundingtestproject')
	    expect(page).not_to have_content('no projects yet')
	  end

	end
end
