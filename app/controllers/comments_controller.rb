class CommentsController < ApplicationController
  def new
    @post = post
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comments_params(current_user, post))

    if @comment.valid?
      redirect_to user_post_path(current_user, post), notice: t('.created')
    else
      redirect_to new_post_comment_path(current_user, post), alert: t('.not_created')
    end
  end

  private

  def comments_params(author, post)
    comment = params.require(:comment).permit(:text)
    comment[:author] = author
    comment[:post] = post
    comment
  end

  def post
    Post.find(params[:post_id])
  end
end
