class Api::V1::UsersController < ActionController::API
  load_and_authorize_resource

  def index
    @posts = User.find(params[:user_id]).posts
    render json: { success: true, data: { posts: @posts } }
  end
end
