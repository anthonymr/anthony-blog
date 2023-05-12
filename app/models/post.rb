class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  after_commit :update_post_counter, on: %i[create destroy]

  def initialize(post_params)
    post_params.nil? ? super : super(post_params.merge(comments_counter: 0, likes_counter: 0))
  end

  def last_comments
    comments.last(5)
  end

  def update_post_counter
    author.update(posts_counter: author.posts.count)
  end

  def likes_by(user)
    likes.where(author: user)
  end
end
