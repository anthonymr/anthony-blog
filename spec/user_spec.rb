require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John', photo: 'http://placekitten.com/g/200/300', bio: 'test user', posts_counter: 0) }

  before { subject.save }

  describe 'New user' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a counter less than zero' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe 'User methods' do
    context 'when user has 3 posts' do
      before do
        3.times { |i| Post.create(author: subject, title: "post #{i}", comments_counter: 0, likes_counter: 0) }
      end

      it 'last_posts should return 3 posts' do
        expect(User.last_posts(User.find(subject.id)).length).to eq(3)
      end
    end

    context 'when user has 5 posts' do
      before do
        5.times { |i| Post.create(author: subject, title: "post #{i}", comments_counter: 0, likes_counter: 0) }
      end

      it 'last_posts should return 3 posts' do
        expect(User.last_posts(User.find(subject.id)).length).to eq(3)
      end
    end

    context 'when user has 0 posts' do
      it 'last_posts should return 0 posts' do
        expect(User.last_posts(User.find(subject.id)).length).to eq(0)
      end
    end

    context 'when user has 2 posts' do
      before do
        2.times { |i| Post.create(author: subject, title: "post #{i}", comments_counter: 0, likes_counter: 0) }
      end

      it 'last_posts should return 2 posts' do
        expect(User.last_posts(User.find(subject.id)).length).to eq(2)
      end
    end
  end
end
