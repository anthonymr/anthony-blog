class CommentsController < ApplicationController
  def new
    @post = post
    @comment = Comment.new
  end

  def create
    @comment = post.comments.create(comments_params(current_user))

    if @comment.valid?
      Comment.update_comment_counter(post)
      redirect_to user_post_path(current_user, post), notice: t('.created')
    else
      redirect_to new_post_comment_path(current_user, post), alert: t('.not_created')
    end
  end

  private

  def comments_params(author)
    comment = params.require(:comment).permit(:text)
    comment[:author] = author
    comment
  end

  def post
    Post.find(params[:post_id])
  end
end
