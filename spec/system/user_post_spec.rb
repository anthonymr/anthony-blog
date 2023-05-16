require 'rails_helper'

describe 'User post index page', type: :feature do
  before :each do
    user = User.create(id: 1, name: 'user1', photo: 'photo1', bio: 'a test user', posts_counter: 0)

    user.posts.create(id: 1, title: 'title1', text: 'text1', likes_counter: 0, comments_counter: 0)
    user.posts.create(id: 2, title: 'title2', text: 'text2', likes_counter: 0, comments_counter: 0)
    user.posts.create(id: 3, title: 'title3', text: 'text3', likes_counter: 0, comments_counter: 0)
    user.posts.create(id: 4, title: 'title4', text: 'text4', likes_counter: 0, comments_counter: 0)
    @post = user.posts.create(id: 5, title: 'title5', text: 'a very long text description jus for testing',
                              likes_counter: 0, comments_counter: 0)

    @post.comments.create(text: 'comment1', author: user)
    @post.likes.create(author: user)
    @post.likes.create(author: user)

    I18n.locale = :en

    visit user_posts_path(user.id)
  end

  it 'I can see the user\'s profile picture.' do
    expect(page).to have_selector('.user__picture', count: 1)
  end

  it 'I can see the user\'s username.' do
    expect(page).to have_content 'user1'
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content 'Number of posts: 5'
  end

  it 'I can see a post\'s title.' do
    expect(page).to have_content 'title1'
  end

  it 'I can see some of the post\'s body.' do
    expect(page).to have_content "#{@post.text[0..16]}..."
  end

  it 'I can see the first comments on a post.' do
    expect(page).to have_content 'title1'
    expect(page).to have_content 'text1'
    expect(page).to have_content 'Comments: 0'
    expect(page).to have_content 'Likes: 0'
  end

  it 'I can see how many comments a post has.' do
    expect(page).to have_content('Comments: 1', count: 1)
  end

  it 'I can see how many likes a post has.' do
    expect(page).to have_content('Likes: 2', count: 1)
  end

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
    expect(page).to have_button(I18n.t('common.pagination'))
  end

  it 'When I click on a post, it redirects me to that post\'s show page.' do
    click_on 'title1'

    expect(page).to have_current_path(user_post_path(1, 1))
  end
end
