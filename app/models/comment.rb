class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def self.update_comment_counter(post)
    return unless post

    count = Comment.where(post_id: post[:id]).count
    post.update(comments_counter: count)
  end
end
