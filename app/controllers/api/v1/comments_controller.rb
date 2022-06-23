class Api::V1::CommentsController < ApplicationController
	  before_action :authorize_request
  before_action :set_post, only: [:create]
  before_action :set_comment, only: [:update, :destroy]

  def create
    return render json: {errors: "Post not found"},status: 404 if @post.nil?
    comment = @post.comments.create(comment_params.merge(user_id: @current_user.id))
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def update
    return render json: {errors: "You don't have access to update this comment"},
      status: 400 unless @comment.user_is_author?(@current_user.id)
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    return render json: {errors: "You don't have access to delete this comment"},
      status: 400 unless @comment.user_is_author?(@current_user.id)
    @comment.destroy
    render json: {errors: "Deleted!"}, status: :ok
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find_by(id: params[:post_id])
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end
end
