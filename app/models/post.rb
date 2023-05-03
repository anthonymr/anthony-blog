class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  def self.last_comments(post)
    return [] unless post

    post.comments.last(5)
  end

  def self.update_post_counter(user)
    return unless user

    user.update(posts_counter: user.posts.count)
  end
end
