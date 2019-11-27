require 'rails_helper'

RSpec.feature 'Login', type: :feature do
  let :user do
    create(:user)
  end

  scenario 'user navigates to login page and successfull logs in', js: true do
    user
    visit root_path
    find('nav a', text: 'Login').click
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    find('.login-button').click
    expect(page).to have_selector('#user-settings')
  end
end
