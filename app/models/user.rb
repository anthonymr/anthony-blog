class User < ApplicationRecord
  has_many :post
  has_many :comment
  has_many :like

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  def self.last_posts(user)
    return unless user

    Post.where(author_id: user[:id]).order(created_at: :desc).limit(3)
  end
end
