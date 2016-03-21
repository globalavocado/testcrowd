require 'rails_helper'

  def signup_user (email, password)
    visit '/' 
    click_link 'sign up' 
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    click_button 'Sign up' 
  end

feature 'projects:' do

  context 'no projects have been added' do
    scenario 'should display a prompt to add a project' do
      signup_user('test@example.com', 'password123')
      visit '/projects'
      expect(page).to have_content 'no projects yet!'
      expect(page).to have_link 'add a project'
    end
  end

  context 'creating projects:' do
    scenario 'users who are not logged in cannot add projects' do
      visit '/'
      expect(page).not_to have_content 'no projects yet!'
      expect(page).not_to have_link 'add a project'
    end

    scenario 'prompts user to fill out a form, then displays the new project' do
      signup_user('test@example.com', 'password123')
      click_link 'add a project'
      fill_in 'Name', with: 'Crowdfundingtestproject'
      fill_in 'Description', with: 'this is the description'
      click_button 'create project'
      click_link 'Crowdfundingtestproject'
      expect(page).to have_content 'Crowdfundingtestproject'
      expect(page).to have_content 'this is the description'
    end
  end

  context 'projects have been added:' do
    before do
      signup_user('test@example.com', 'password123')
      click_link 'add a project'
      fill_in 'Name', with: 'Crowdfundingtestproject'
      click_button 'create project'
    end

    scenario 'display projects' do
      visit '/projects'
      expect(page).to have_content('Crowdfundingtestproject')
      expect(page).not_to have_content('no projects yet')
    end

  end

  context 'viewing projects:' do
    before do
      signup_user('test2@example.com', 'password678')
      click_link 'add a project'
      fill_in 'Name', with: "Crowdfundingtestproject"
      click_button 'create project'
    end

    scenario 'a user not logged in cannot view projects' do
      click_link 'log out'
      visit '/'
      expect(page).not_to have_content('Crowdfundingtestproject')
    end

    scenario 'lets a user view a project page' do
      visit '/projects'
      click_link 'Crowdfundingtestproject'
      expect(page).to have_content 'Crowdfundingtestproject'
    end

    scenario 'display user email to identify creator of project' do
      click_link 'log out'
      visit '/projects'
      signup_user('test@example.com', 'password123')
      click_link 'add a project'
      fill_in 'Name', with: "Chris' fantastic flying Cola bottles"
      click_button 'create project'
      click_link "Chris' fantastic flying Cola bottles"
      expect(page).to have_content('added by test@example.com')
    end

  end

  context 'editing projects:' do
    before do
      signup_user('test@example.com', 'password123')
      click_link 'add a project'
      fill_in 'Name', with: 'Crowdfundingtestproject'
      click_button 'create project'
    end

    scenario 'let a user edit a project' do
      visit '/projects'
      click_link 'edit Crowdfundingtestproject'
      fill_in 'Name', with: 'The Fantastic Crowdfunding Project'
      click_button 'update project'
      expect(page).to have_content 'The Fantastic Crowdfunding Project'
      expect(current_path).to eq '/projects'
    end

    scenario 'users can only edit their own projects' do
      click_link 'log out'
      signup_user('test2@example.com', 'password678')
      visit '/projects'
      click_link 'edit Crowdfundingtestproject'
      expect(page).to have_content("you cannot edit somebody else's project.")
    end

  end

  context 'deleting projects:' do
    before do
      signup_user('test@example.com', 'password123')
      click_link 'add a project'
      fill_in 'Name', with: 'Crowdfundingtestproject'
      click_button 'create project'
    end

    scenario 'removes a project when a user clicks a delete link' do
      visit '/projects'
      click_link 'delete Crowdfundingtestproject'
      expect(page).not_to have_content 'Crowdfundingtestproject'
      expect(page).to have_content 'Project deleted successfully'
    end

    scenario 'users can only delete their own projects' do
      click_link 'log out'
      signup_user('test2@example.com', 'password678')
      visit '/projects'
      click_link 'delete Crowdfundingtestproject'
      expect(page).to have_content("you cannot delete somebody else's project.")
    end

    scenario 'logged out users will not see links to edit or delete projects' do
      click_link 'log out'
      visit '/projects'
      expect(page).not_to have_link('edit Crowdfundingtestproject')
      expect(page).not_to have_link('delete Crowdfundingtestproject')
    end

  end

  context 'an invalid project:' do

    it 'does not let you submit a name that is too short' do
      visit '/projects'
      signup_user('test@example.com', 'password123')
      click_link 'add a project'
      fill_in 'Name', with: 'Cr'
      click_button 'create project'
      expect(page).not_to have_css 'h2', text: 'Cr'
      expect(page).to have_content 'error'
    end

  end

end