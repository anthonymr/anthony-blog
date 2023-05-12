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
    if current_user.posts.create(post_params).valid?
      redirect_to user_posts_path(current_user), notice: t('.created')
    else
      redirect_to new_user_post_path(current_user), alert: t('.not_created')
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
