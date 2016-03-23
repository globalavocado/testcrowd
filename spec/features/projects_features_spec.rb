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

feature 'projects:' do

  context 'no projects have been added' do
    scenario 'should not display a prompt to add a project for regular users' do
      user = create :user1
      login_user('user1@example.com', 'password123')
      visit '/projects'
      expect(page).to have_content 'no projects yet!'
      expect(page).not_to have_link 'add a project'
    end

    scenario 'should display a link to add a project for admins' do
      user = create :admin1
      login_user('admin1@example.com', 'password678')
      visit '/projects'
      expect(page).to have_content 'no projects yet!'
      expect(page).to have_link 'add a project'
    end
  end

  context 'creating projects:' do
    scenario 'admins who are not logged in cannot add projects' do
      visit '/'
      expect(page).not_to have_link 'add a project'
    end

    scenario 'prompts admin to fill out a form, then displays the new project' do
      user = create :admin1 
      login_user('admin1@example.com', 'password678')
      add_project('Crowdfundingtestproject', 'this is the description')
      click_link 'Crowdfundingtestproject'
      expect(page).to have_content 'Crowdfundingtestproject'
      expect(page).to have_content 'this is the description'
    end
  end

  context 'projects have been added:' do
    before do
      user = create :admin1 
      login_user('admin1@example.com', 'password678')
      add_project('Crowdfundingtestproject', 'this is the description')
    end

    scenario 'display projects' do
      visit '/projects'
      expect(page).to have_content('Crowdfundingtestproject')
      expect(page).not_to have_content('no projects yet')
    end

  end

  context 'viewing projects:' do
    before do
      user = create :admin1 
      login_user('admin1@example.com', 'password678')
      add_project('Crowdfundingtestproject', 'this is the description')
    end

    scenario 'a user not logged in cannot view projects' do
      click_link 'log out'
      visit '/'
      expect(page).to have_content('Please join our community to test your campaign before it goes live.')
      expect(page).not_to have_content('Crowdfundingtestproject')
    end

    scenario 'lets a user view a project page' do
      click_link 'log out'
      user = create :user1 
      login_user('user1@example.com', 'password123')
      visit '/projects'
      click_link 'Crowdfundingtestproject'
      expect(page).to have_content 'Crowdfundingtestproject'
    end

    scenario 'display user email to identify creator of project' do
      add_project("Chris' fantastic flying Cola bottles", "this is the description")
      click_link "Chris' fantastic flying Cola bottles"
      expect(page).to have_content('added by admin1@example.com')
    end

  end

  context 'editing projects:' do
    before do
      user = create :admin1 
      login_user('admin1@example.com', 'password678')
      add_project('Crowdfundingtestproject', 'this is the description')
    end

    scenario 'lets a user edit a project' do
      visit '/projects'
      click_link 'edit Crowdfundingtestproject'
      fill_in 'Name', with: 'The Fantastic Crowdfunding Project'
      click_button 'update project'
      expect(page).to have_content 'The Fantastic Crowdfunding Project'
      expect(current_path).to eq '/projects'
    end

    scenario 'users can only edit their own projects' do
      click_link 'log out'
      user = create :admin2 
      login_user('admin2@example.com', 'password789')
      visit '/projects'
      click_link 'edit Crowdfundingtestproject'
      expect(page).to have_content("you cannot edit somebody else's project.")
    end

  end

  context 'deleting projects:' do
    before do
      user = create :admin1 
      login_user('admin1@example.com', 'password678')
      add_project('Crowdfundingtestproject', 'this is the description')
    end

    scenario 'removes a project when an admin clicks a delete link' do
      visit '/projects'
      click_link 'delete Crowdfundingtestproject'
      expect(page).not_to have_content 'Crowdfundingtestproject'
      expect(page).to have_content 'Project deleted successfully'
    end

    scenario 'users can only delete their own projects' do
      click_link 'log out'
      user = create :admin2 
      login_user('admin2@example.com', 'password789')
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
      user = create :admin1 
      login_user('admin1@example.com', 'password678')
      add_project('Cr', 'this is the description')
      click_button 'create project'
      expect(page).not_to have_css 'h2', text: 'Cr'
      expect(page).to have_content 'error'
    end

  end

end