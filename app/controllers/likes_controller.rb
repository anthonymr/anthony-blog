class LikesController < ApplicationController
  def create
    post = Post.includes(:likes).find(params[:post_id])
    likes = post.likes_by(current_user)

    likes.any? ? likes.each(&:destroy) : Like.create(post:, author: current_user)

    redirect_to user_posts_path(post.author)
  end
end
