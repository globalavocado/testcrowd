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

	context 'creating restaurants:' do
		scenario 'prompts user to fill out a form, then displays the new project' do
			visit '/projects'
			click_link 'add a project'
			fill_in 'Name', with: 'Crowdfundingtestproject'
			click_button 'create project'
			expect(page).to have_content 'Crowdfundingtestproject'
			expect(current_path).to eq '/projects'
		end
	end

	context 'viewing projects:' do
	  let!(:crowdfundingtestproject){Project.create(name:'Crowdfundingtestproject')}

	  scenario 'lets a user view a project' do
	    visit '/projects'
	    click_link 'Crowdfundingtestproject'
	    expect(page).to have_content 'Crowdfundingtestproject'
	    expect(current_path).to eq "/projects/#{crowdfundingtestproject.id}"
	  end
	end

end
