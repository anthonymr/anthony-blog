class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  after_commit :update_like_counter, on: %i[create destroy]

  def update_like_counter
    post.update(likes_counter: post.likes.count) unless post.destroyed?
  end
end
