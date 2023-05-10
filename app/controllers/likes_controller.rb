class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    Like.create(post: @post, author: current_user)
    redirect_to user_posts_path(@post.author)
  end
end
