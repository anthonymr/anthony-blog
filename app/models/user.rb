class User < ApplicationRecord
  has_many :post
  has_many :comment
  has_many :like

  def self.last_posts(user)
    return unless user

    Post.where(author_id: user[:id]).order(created_at: :desc).limit(3)
  end
end
