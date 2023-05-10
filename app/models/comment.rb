class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def initialize(comment_params)
    super
    Comment.update_comment_counter(comment_params[:post]) if comment_params
  end

  def self.update_comment_counter(post)
    post.update(comments_counter: post.comments.count)
  end
end
