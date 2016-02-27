require 'rails_helper'

feature 'user can sign in and out' do
  context 'user not signed in and on home page' do
    it 'should see a sign in link and a sign up link' do
      visit('/')
      expect(page).to have_link('log in')
      expect(page).to have_link('sign up')
    end

    it 'should not see the sign out link' do
      visit('/')
      expect(page).not_to have_link('log out')
    end
  end

  context 'user signed in on the home page' do
    before do
      visit('/')
      click_link('sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'password123')
      fill_in('Password confirmation', with: 'password123')
      click_button('Sign up')
    end

    it 'should see sign out link' do
      visit('/')
      expect(page).not_to have_link('log in')
      expect(page).not_to have_link('sign up')
    end
  end

end