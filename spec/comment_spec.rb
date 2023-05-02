require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John', photo: 'http://placekitten.com/g/200/300', bio: 'test user', posts_counter: 0) }
  let(:post) { Post.create(author: user, title: 'testing post', comments_counter: 0, likes_counter: 0) }
  subject { Comment.create(post:, author: user, text: 'testing comment') }

  describe 'New comment' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end

  describe 'Comment methods' do
    it 'update_comment_counter should update comments_counter' do
      expect(post.comments_counter).to eq(0)
      Comment.create(post:, author: user, text: 'testing comment')
      Comment.update_comment_counter(post)
      expect(post.comments_counter).to eq(1)
    end
  end
end
