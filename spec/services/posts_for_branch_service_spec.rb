require 'rails_helper'
# require './app/services/posts_for_branch_service.rb'

describe PostsForBranchService do
  context '#call' do
    let(:not_included_posts) { create_list(:post, 2) }
    let(:category) { create(:category, branch: 'hobby', name: 'arts') }
    let(:post) { create(:post, title: 'a very fun post', category_id: category.id) }

    it 'returns posts filtered by branch' do
      not_included_posts
      category
      included_posts = create_list(:post, 2, category_id: category.id)
      expect(PostsForBranchService.new(branch: 'hobby').call).to match_array(included_posts)
    end

    it 'returns posts filtered by branch and search' do
      not_included_posts
      category
      included_posts = [] << post
      expect(PostsForBranchService.new(branch: 'hobby', search: 'fun').call).to eq(included_posts)
    end

    it 'returns posts filtered by category name' do
      not_included_posts
      category
      included_posts = [] << post
      expect(PostsForBranchService.new(branch: 'hobby', category: 'arts').call).to eq included_posts
    end

    it 'returns posts filtered by a category name and a search input' do
      not_included_posts
      category
      included_posts = [] << post
      expect(PostsForBranchService.new(branch: 'hobby', search: 'fun', name: 'arts').call).to eq included_posts  
    end
  end
end
