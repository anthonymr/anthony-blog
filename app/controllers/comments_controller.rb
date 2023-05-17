class CommentsController < ApplicationController
  load_and_authorize_resource
  
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

  def destroy
    comment = Comment.find(params[:id])

    if comment.destroy
      redirect_to user_post_path(comment.author, post), notice: t('.deleted')
      post.update_post_counter
    else
      redirect_to user_post_path(comment.author, post), alert: t('.not_deleted')
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
