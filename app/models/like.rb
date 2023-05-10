class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def initialize(like_params)
    super(like_params)
    Like.update_like_counter(like_params[:post])
  end

  def self.update_like_counter(post)
    post.update(likes_counter: post.likes.count)
  end
end
