require 'rails_helper'
RSpec.describe PostsHelper, type: :helper do
  context '#create_new_partial_path' do
    it "returns signed_in partial's path" do
      allow(helper).to receive(:user_signed_in?).and_return(true)
      expect(
        helper.create_new_post_partial_path
      ).to eq 'posts/branch/create_new_post/signed_in'
    end

    it "returns not_signed_in partial's path" do
      allow(helper).to receive(:user_signed_in?).and_return(false)
      expect(
        helper.create_new_post_partial_path
      ).to eq 'posts/branch/create_new_post/not_signed_in'
    end
  end

  context '#all_categories_button_partial_path' do
    it "returns all_selected partial's path" do
      controller.params[:category] = ''
      expect(
        helper.all_categories_button_partial_path
      ).to eq 'posts/branch/categories/all_selected'
    end

    it "returns all_not_selected partial's path" do
      controller.params[:category] = 'category'
      expect(
        helper.all_categories_button_partial_path
      ).to eq 'posts/branch/categories/all_not_selected'
    end
  end

  context '#no_post_partial_path' do
    it "returns no_post partial's path" do
      assign(:posts, [])
      expect(helper.no_post_partial_path).to eq 'posts/branch/no_post'
    end

    it "returns empty partials's path" do
      assign(:posts, [1])
      expect(helper.no_post_partial_path).to eq 'shared/empty_partial'
    end
  end

  context '#post_format_partial_path' do
    it "return home_page partial's path" do
      allow(helper).to receive(:current_page?).and_return(true)
      expect(helper.post_format_partial_path).to eq 'posts/post/home_page'
    end

    it "return branch_page partial's path" do
      allow(helper).to receive(:current_page?).and_return(false)
      expect(helper.post_format_partial_path).to eq 'posts/post/branch_page'
    end
  end

  context '#update_pagination_partial_path' do
    it "returns an update_pagination partial's path" do
      posts = double('posts', :next_page => 2)
      assign(:posts, posts)
      expect(helper.update_pagination_partial_path).to(
        eq 'posts/posts_pagination_page/update_pagination'
      )
    end

    it "returns a remove_pagination partial's path" do
      posts = double('posts', :next_page => nil)
      assign(:posts, posts)
      expect(helper.update_pagination_partial_path).to(
        eq 'posts/posts_pagination_page/remove_pagination'
      )
    end
  end
end
