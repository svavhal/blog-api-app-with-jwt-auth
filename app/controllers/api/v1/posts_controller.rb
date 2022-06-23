class Api::V1::PostsController < ApplicationController
  before_action :authorize_request
  before_action :set_post, only: [:update, :destroy]

  def index
    @posts = Post.all
    render json: @posts, status: :ok
  end

  def create
    @post = @current_user.posts.create(post_params)
    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    return render json: {errors: "You don't have access to update this post"},
      status: 400 unless @post.user_is_author?(@current_user.id)
    if @post.update(post_params)
      render json: @post, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    return render json: {errors: "You don't have access to delete this post"},
      status: 400 unless @post.user_is_author?(@current_user.id)
    @post.destroy
    render json: {errors: "Deleted!"}, status: :ok
  end

  def list_current_user_posts
    @posts = @current_user.posts
      if @posts.blank?
        return render json: {errors: "posts not found for current logged in user"}, status: 402
    else
      render json: @posts, status: 200
    end
  end

  def list_posts_by_user_id
    @posts = Post.where(user_id: params[:user_id])
    if @posts.blank?
        return render json: {errors: "posts not found for given user id"}, status: 402
    else
      render json: @posts, status: 200
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
