require 'rails_helper'

RSpec.feature 'Logout', type: :feature do
  let :user do
    create(:user)
  end

  scenario 'user successfully logs out', js: true do
    sign_in user
    visit root_path
    find('nav #user-settings').click
    find('nav a', text: 'Logout').click
    expect(page).to have_selector('nav a', text: 'Login')
  end
end
