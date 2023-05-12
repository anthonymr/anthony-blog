class CommentsController < ApplicationController
  def new
    @post = post
    @comment = Comment.new
  end

  def create
    @comment = post.comments.create(comments_params.merge(author: current_user))

    if @comment.valid?
      redirect_to user_post_path(current_user, post), notice: t('.created')
    else
      redirect_to new_post_comment_path(post), alert: t('.not_created')
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:text)
  end

  def post
    Post.find(params[:post_id])
  end
end
