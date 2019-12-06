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
  end
end
