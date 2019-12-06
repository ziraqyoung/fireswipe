require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Associations' do
    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
    it 'belongs to a category' do
      association = described_class.reflect_on_association(:category)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  context 'Scopes' do
    it 'default_scope orders posts by created_at descending' do
      first_post = create(:post)
      second_post = create(:post)
      expect(Post.all).to eq [second_post, first_post]
    end

    it 'by_category scope gets posts by a particular category' do
      category = create(:category)
      create(:post, category_id: category.id)
      create_list(:post, 10)
      posts = Post.by_category(category.branch, category.name)
      expect(posts.count).to eq 1
      expect(posts[0].category.name).to eq category.name
    end

    it 'by_branch scope gets posts by a particular branch' do
      category = create(:category)
      create(:post, category_id: category.id)
      create_list(:post, 10)
      posts = Post.by_branch(category.branch)
      expect(posts.count).to eq 1
      expect(posts[0].category.branch).to eq category.branch
    end
    it 'search scope gets a matching post' do
      post =
        create(:post, title: 'awesome titile', content: 'great content' * 5)
      create_list(:post, 10, title: ('a'..'b').to_a.shuffle.join)
      expect(Post.search('awesome').count).to eq 1
      expect(Post.search('awesome')[0].id).to eq post.id
      expect(Post.search('content').count).to eq 1
      expect(Post.search('content')[0].id).to eq post.id
    end
  end
end
