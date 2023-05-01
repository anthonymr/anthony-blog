class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def self.update_like_counter(post)
    return unless post

    count = Like.where(post_id: post[:id]).count
    post.update(likes_counter: count)
  end
end
