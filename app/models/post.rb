class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def self.last_comments(post)
    return unless post

    Comment.where(post_id: post[:id]).order(created_at: :desc).limit(5)
  end

  def self.update_post_counter(user)
    return unless user

    count = Post.where(author_id: user[:id]).count
    user.update(posts_counter: count)
  end
end
