require 'rails_helper'

RSpec.feature 'Visit single page', type: :feature do
  let :user do
    create(:user)
  end
  let :post do
    create(:post)
  end

  scenario 'User goes to single post from home page' do
    # post
    # visit root_path
    # page.find(:link, post_path(post.id).to_s).click
    # expect(page).to have_selector'.container .modal')
    # page.find('.modal a.interested').click
    # expect(page).to have_selector('#single-post-content p', text: post.content)
  end
end
