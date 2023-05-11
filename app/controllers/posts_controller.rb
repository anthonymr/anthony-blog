class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments).order(created_at: :desc)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @user = @post.author
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.create(post_params(current_user))

    if @post.valid?
      redirect_to user_post_path(current_user, @post), notice: t('.created')
    else
      redirect_to new_user_post_path(current_user), alert: t('.not_created')
    end
  end

  private

  def post_params(author)
    post = params.require(:post).permit(:title, :text)
    post[:author] = author
    post
  end
end
