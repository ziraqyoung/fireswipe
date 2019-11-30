require 'rails_helper'

RSpec.feature 'Visit single page', type: :feature do
  let :user do
    create(:user)
  end
  let :post do
    create(:post)
  end

  scenario 'User goes to single post from home page', js: true do
    post
    visit root_path
    page.find('.single-post-card').click
    expect(page).to have_selector('.container .modal')
    page.find('.modal a.interested').click
    expect(page).to have_selector('#single-post-content p', text: post.content)
  end
end
