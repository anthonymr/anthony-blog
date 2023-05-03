class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def self.update_like_counter(post)
    return unless post

    post.update(likes_counter: post.likes.count)
  end
end
