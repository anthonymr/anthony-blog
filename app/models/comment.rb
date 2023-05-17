class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :text, presence: true, length: { maximum: 500 }

  after_commit :update_comment_counter, on: %i[create destroy]

  def update_comment_counter
    post.update(comments_counter: post.comments.count) unless post.destroyed?
  end
end
