class User < ApplicationRecord
  def self.last_posts(user)
    return unless user

    Post.where(author_id: user[:id]).order(created_at: :desc).limit(3)
  end
end
