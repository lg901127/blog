class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  def authenticate_user!
    redirect_to new_session_path, alert: "Please sign in" unless user_signed_in?
  end
  def index
    @comments = Comment.order("created_at")
  end

  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find params[:id]
  end

  def create
    @post = Post.find params[:post_id]
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new comment_params
    @comment.post = @post
    if @comment.save
      redirect_to blog_path(@post), notice: "Comment saved"
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find params[:id]
    @post = @comment.post
  end

  def update
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    comment_params = params.require(:comment).permit(:body)
    if @comment.update comment_params
      redirect_to blog_path(@post)
    else
      redirect_to edit_post_comment_path(@post, @comment)
    end
  end

  def destroy
    @post = Post.find params[:post_id]
    @comment = Comment.find params[:id]
    @comment.destroy
    redirect_to blog_path(@post), notice: "Comment deleted"
  end
end
