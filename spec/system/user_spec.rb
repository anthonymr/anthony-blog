require 'rails_helper'

describe 'User index page', type: :feature do
  before :each do
    User.create(name: 'user1', photo: 'photo1', bio: 'a test user', posts_counter: 0)
    User.create(name: 'user2', photo: 'photo1', bio: 'a test user', posts_counter: 0)
    User.create(name: 'user3', photo: 'photo1', bio: 'a test user', posts_counter: 0)
  end

  it 'I can see the username of all other users.' do
    visit '/users'
    expect(page).to have_content 'user1'
    expect(page).to have_content 'user2'
    expect(page).to have_content 'user3'

    expect(page).to have_selector('.user__name', count: 3)
  end
end