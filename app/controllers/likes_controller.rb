class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    likes = post.likes.where(author: current_user)

    likes.any? ? likes.each(&:destroy) : Like.create(post: post, author: current_user)

    Like.update_like_counter(post)
    redirect_to user_posts_path(post.author)
  end
end
