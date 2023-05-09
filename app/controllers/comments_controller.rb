class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user

    @comment = @post.comments.create(comments_params(@user))

    if @comment.valid?
      redirect_to user_post_path(@user, @post), notice: t('.created')
    else
      redirect_to new_user_post_comment_path(@user, @post), alert: t('.not_created')
    end
  end

  private

  def comments_params(author)
    comment = params.require(:comment).permit(:text)
    comment[:author] = author
    comment
  end
end
