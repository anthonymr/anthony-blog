require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John', photo: 'http://placekitten.com/g/200/300', bio: 'test user', posts_counter: 0) }
  subject { Post.create(author: user, title: 'testing post', comments_counter: 0, likes_counter: 0) }

  describe 'New post' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a comments_counter less than zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'is not valid with a likes_counter less than zero' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe 'Post methods' do
    context 'when post has 5 comments' do
      before do
        5.times { |i| Comment.create(post: subject, author: user, text: "comment #{i}") }
      end

      it 'last_comments should return 5 comments' do
        expect(Post.last_comments(Post.find(subject.id)).length).to eq(5)
      end
    end

    context 'when post has 7 comments' do
      before do
        7.times { |i| Comment.create(post: subject, author: user, text: "comment #{i}") }
      end

      it 'last_comments should return 5 comments' do
        expect(Post.last_comments(Post.find(subject.id)).length).to eq(5)
      end
    end

    context 'when post has 0 comments' do
      it 'last_comments should return 0 comments' do
        expect(Post.last_comments(Post.find(subject.id)).length).to eq(0)
      end
    end

    context 'when post has 3 comments' do
      before do
        3.times { |i| Comment.create(post: subject, author: user, text: "comment #{i}") }
      end

      it 'last_comments should return 3 comments' do
        expect(Post.last_comments(Post.find(subject.id)).length).to eq(3)
      end
    end
  end
end
