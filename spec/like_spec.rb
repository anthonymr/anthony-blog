require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John', photo: 'http://placekitten.com/g/200/300', bio: 'test user', posts_counter: 0) }
  let(:post) { Post.create(author: user, title: 'testing post', comments_counter: 0, likes_counter: 0) }
  subject { Like.create(post:, author: user) }

  describe 'New like' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end

  describe 'Like methods' do
    it 'update_like_counter should update likes_counter' do
      expect(post.likes_counter).to eq(0)
      Like.create(post:, author: user)
      Like.update_like_counter(post)
      expect(post.likes_counter).to eq(1)
    end
  end
end
