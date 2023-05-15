require 'rails_helper'

describe 'User index page', type: :feature do
  before :each do
    User.create(id: 1, name: 'user1', photo: 'photo1', bio: 'a test user', posts_counter: 0)
    User.create(id: 2, name: 'user2', photo: 'photo1', bio: 'a test user', posts_counter: 0)
    user = User.create(id: 3, name: 'user3', photo: 'photo1', bio: 'a test user', posts_counter: 0)

    user.posts.create(title: 'title1', text: 'text1', likes_counter: 0, comments_counter: 0)

    visit '/users'
  end

  it 'I can see the username of all other users.' do
    expect(page).to have_content 'user1'
    expect(page).to have_content 'user2'
    expect(page).to have_content 'user3'

    expect(page).to have_selector('.user__name', count: 3)
  end

  it 'I can see the profile picture for each user.' do
    expect(page).to have_selector('.user__picture', count: 3)
  end

  it 'I can see the number of posts of all other users.' do
    expect(page).to have_content('Number of posts: 0', count: 2)
    expect(page).to have_content('Number of posts: 1', count: 1)

    expect(page).to have_selector('.user__posts-count', count: 3)
  end

  it 'When I click on a user, I am redirected to that users show page.' do
    click_on 'user1'

    expect(page).to have_current_path('/users/1')
  end
end
